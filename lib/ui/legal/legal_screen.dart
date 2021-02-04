import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';

class LegalScreen extends StatefulWidget {
  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  bool healthDataProcessingAgreed;
  bool privacyPolicyAgreed;
  bool usageRulesAgreed;
  bool communicationAgreed;

  bool get _canContinue =>
      healthDataProcessingAgreed && privacyPolicyAgreed && usageRulesAgreed;

  bool get _agreedToEverything => _canContinue && communicationAgreed;

  @override
  void initState() {
    super.initState();

    privacyPolicyAgreed = false;
    usageRulesAgreed = false;
    healthDataProcessingAgreed = false;
    communicationAgreed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.termsOfUse)),
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
                        Constants.privacyPolicyUrl,
                      ),
                      value: healthDataProcessingAgreed,
                      onChanged: (b) =>
                          setState(() => healthDataProcessingAgreed = b),
                    ),
                    AppCheckboxListTile(
                      title: _buildTextWithUrl(
                        appLocalizations.loginConditionsAgree,
                        appLocalizations.privacyPolicy,
                        Constants.privacyPolicyUrl,
                      ),
                      value: privacyPolicyAgreed,
                      onChanged: (b) => setState(() => privacyPolicyAgreed = b),
                    ),
                    AppCheckboxListTile(
                      title: _buildTextWithUrl(
                        appLocalizations.loginConditionsAgree,
                        appLocalizations.usageRules,
                        Constants.rulesUrl,
                      ),
                      value: usageRulesAgreed,
                      onChanged: (b) => setState(() => usageRulesAgreed = b),
                    ),
                  ],
                ),
                SmallSection(
                  title: appLocalizations.optionally,
                  children: [
                    AppCheckboxListTile(
                      title: Text(appLocalizations.agreeToCommunicate),
                      value: communicationAgreed,
                      onChanged: (b) => setState(() => communicationAgreed = b),
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
                    onPressed: _canContinue
                        ? () => Navigator.pop(context, false)
                        : null,
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
      healthDataProcessingAgreed = b;
      privacyPolicyAgreed = b;
      usageRulesAgreed = b;

      communicationAgreed = b;
    });
  }
}
