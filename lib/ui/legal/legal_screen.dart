import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';

enum LegalScreenExitType {
  close,
  login,
}

class LegalScreenArguments {
  final LegalScreenExitType exitType;

  const LegalScreenArguments(this.exitType);
}

class LegalScreen extends StatefulWidget {
  final LegalScreenExitType exitType;

  const LegalScreen({Key key, @required this.exitType})
      : assert(exitType != null),
        super(key: key);

  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  final _appPreferences = AppPreferences();

  bool _healthDataProcessingAgreed;
  bool _privacyPolicyAgreed;
  bool _usageRulesAgreed;
  bool _communicationAgreed;

  bool get _canContinue =>
      _healthDataProcessingAgreed && _privacyPolicyAgreed && _usageRulesAgreed;

  bool get _agreedToEverything => _canContinue && _communicationAgreed;

  @override
  void initState() {
    super.initState();

    final initial = widget.exitType == LegalScreenExitType.close;

    _privacyPolicyAgreed = initial;
    _usageRulesAgreed = initial;
    _healthDataProcessingAgreed = initial;

    _communicationAgreed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const CloseButton() : null,
        title: Text(appLocalizations.termsOfUse),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                BasicSection(
                  header: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AppListTile(
                      leading: const IconButton(
                        icon: Icon(Icons.info),
                        onPressed: null,
                      ),
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
                        appLocalizations.loginConditionsAgree,
                        appLocalizations.healthDataProcessing,
                        Constants.healthDataProcessingPolicyUrl,
                      ),
                      value: _healthDataProcessingAgreed,
                      onChanged: (b) =>
                          setState(() => _healthDataProcessingAgreed = b),
                    ),
                    AppCheckboxListTile(
                      title: _buildTextWithUrl(
                        appLocalizations.loginConditionsAgree,
                        appLocalizations.privacyPolicy,
                        Constants.privacyPolicyUrl,
                      ),
                      value: _privacyPolicyAgreed,
                      onChanged: (b) =>
                          setState(() => _privacyPolicyAgreed = b),
                    ),
                    AppCheckboxListTile(
                      title: _buildTextWithUrl(
                        appLocalizations.loginConditionsAgree,
                        appLocalizations.usageRules,
                        Constants.rulesUrl,
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
                      value: _communicationAgreed,
                      onChanged: (b) =>
                          setState(() => _communicationAgreed = b),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BasicSection(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppCheckboxListTile(
                  title: Text(appLocalizations.agreeWithAllConditions),
                  subtitle:
                      Text(appLocalizations.agreeWithAllConditionsSubtitle),
                  value: _agreedToEverything,
                  onChanged: _agreeWithEverything,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: _canContinue ? proceed : null,
                    text: appLocalizations.proceed.toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> proceed() async {
    await _appPreferences.setLegalConditionsAgreed();

    switch (widget.exitType) {
      case LegalScreenExitType.close:
        Navigator.pop(context, false);
        break;
      case LegalScreenExitType.login:
        Navigator.pushReplacementNamed(context, Routes.routeLogin);
        break;
    }
  }

  Widget _buildTextWithUrl(String text, String urlText, String url) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(text: "$text "),
          TextSpan(
            text: urlText.toLowerCase(),
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

      _communicationAgreed = b;
    });
  }
}
