import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/utils/utils.dart';

enum LegalScreenExitType {
  close,
  login,
}

class LegalScreenArguments {
  final LegalScreenExitType exitType;

  const LegalScreenArguments(this.exitType);
}

class LegalScreen extends StatelessWidget {
  final _appPreferences = AppPreferences();

  final LegalScreenExitType exitType;

  LegalScreen({super.key, required this.exitType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.appLocalizations.termsOfUse)),
      body: AppFutureBuilder<bool>(
        future: () => _appPreferences.isMarketingAllowed(),
        builder: (context, marketingAllowed) {
          return LegalScreenContent(
            initialMarketingAllowed: marketingAllowed,
            exitType: exitType,
          );
        },
      ),
    );
  }
}

class LegalScreenContent extends StatefulWidget {
  final LegalScreenExitType exitType;
  final bool initialMarketingAllowed;

  const LegalScreenContent({
    super.key,
    required this.exitType,
    required this.initialMarketingAllowed,
  });

  @override
  _LegalScreenContentState createState() => _LegalScreenContentState();
}

class _LegalScreenContentState extends State<LegalScreenContent> {
  final _appPreferences = AppPreferences();
  final _apiService = ApiService();

  bool get _initialAgreed => widget.exitType == LegalScreenExitType.close;

  late bool _healthDataProcessingAgreed;
  late bool _privacyPolicyAgreed;
  late bool _usageRulesAgreed;
  late bool _marketingAllowed;

  bool get _canContinue =>
      _healthDataProcessingAgreed && _privacyPolicyAgreed && _usageRulesAgreed;

  bool get _agreedToEverything => _canContinue && _marketingAllowed;

  @override
  // ignore: avoid_void_async
  void initState() {
    super.initState();

    _privacyPolicyAgreed = _initialAgreed;
    _usageRulesAgreed = _initialAgreed;
    _healthDataProcessingAgreed = _initialAgreed;

    _marketingAllowed = widget.initialMarketingAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              BasicSection(
                header: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AppListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.info_outline)),
                    title: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        appLocalizations.conditionsExplanation,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
              SmallSection(
                title: appLocalizations.mandatory,
                showDividers: true,
                children: [
                  AppCheckboxListTile(
                    title: _buildTextWithUrl(
                      context,
                      appLocalizations.loginConditionsAgreeWith,
                      appLocalizations.agreeWithHealthDataProcessing,
                      appLocalizations.healthDataProcessingPolicyUrl,
                    ),
                    value: _healthDataProcessingAgreed,
                    onChanged: (b) =>
                        setState(() => _healthDataProcessingAgreed = b),
                  ),
                  AppCheckboxListTile(
                    title: _buildTextWithUrl(
                      context,
                      appLocalizations.loginConditionsAgree,
                      appLocalizations.agreeWithPrivacyPolicy,
                      appLocalizations.privacyPolicyUrl,
                    ),
                    value: _privacyPolicyAgreed,
                    onChanged: (b) => setState(() => _privacyPolicyAgreed = b),
                  ),
                  AppCheckboxListTile(
                    title: _buildTextWithUrl(
                      context,
                      appLocalizations.loginConditionsAgree,
                      appLocalizations.agreeWithUsageRules,
                      appLocalizations.fairUseRulesUrl,
                    ),
                    value: _usageRulesAgreed,
                    onChanged: (b) => setState(() => _usageRulesAgreed = b),
                  ),
                ],
              ),
              SmallSection(
                title: appLocalizations.optionally,
                children: [
                  AppCheckboxListTile(
                    title: Text(appLocalizations.agreeToCommunicate),
                    value: _marketingAllowed,
                    onChanged: (b) => setState(() => _marketingAllowed = b),
                  ),
                ],
              ),
            ],
          ),
        ),
        BasicSection(
          margin: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AppCheckboxListTile(
                title: Text(appLocalizations.agreeWithAllConditions),
                subtitle: Text(appLocalizations.agreeWithAllConditionsSubtitle),
                value: _agreedToEverything,
                onChanged: _agreeWithEverything,
              ),
            ),
            SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: AppElevatedButton(
                  onPressed: _canContinue ? proceed : null,
                  label: _initialAgreed
                      ? Text(appLocalizations.save.toUpperCase())
                      : Text(appLocalizations.proceed.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> proceed() async {
    await _appPreferences.setLegalConditionsAgreed();
    await _appPreferences.setMarketingAllowed(_marketingAllowed);

    switch (widget.exitType) {
      case LegalScreenExitType.close:
        await _updateApiUserWithProgressDialog();
        Navigator.pop(context, false);
        break;
      case LegalScreenExitType.login:
        Navigator.pushReplacementNamed(context, Routes.routeLogin);
        break;
    }
  }

  Future<void> _updateApiUserWithProgressDialog() async {
    final userFuture = _apiService.updateUser(
      marketingAllowed: _marketingAllowed,
    );

    try {
      await AppProgressDialog.showForFuture(context, userFuture);
    } catch (ex) {
      if (mounted) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          content: Text(appLocalizations.serverErrorDescription),
        );
      }
    }
  }

  Widget _buildTextWithUrl(
    BuildContext context,
    String text,
    String urlText,
    String url,
  ) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: 16,
        ),
        children: [
          TextSpan(text: '$text '),
          TextSpan(
            text: urlText,
            recognizer: TapGestureRecognizer()..onTap = () => launchPdf(url),
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void _agreeWithEverything(bool b) {
    setState(() {
      _healthDataProcessingAgreed = b;
      _privacyPolicyAgreed = b;
      _usageRulesAgreed = b;

      _marketingAllowed = b;
    });
  }
}
