import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/utils/utils.dart';

class LoginConditionsRichText extends StatelessWidget {
  final Color textColor;
  final TextAlign textAlign;
  final String baseText;

  const LoginConditionsRichText({
    Key key,
    this.textColor,
    this.baseText,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final text = baseText ?? appLocalizations.loginConditionsAgree;

    return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
          text: text,
          style: TextStyle(color: textColor),
        ),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          text: appLocalizations.privacyPolicy,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchPdf(Constants.privacyPolicyUrl),
        ),
        TextSpan(
            text: ' ${appLocalizations.and} ',
            style: TextStyle(
              color: textColor,
            )),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          text: appLocalizations.usageRules,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchPdf(Constants.rulesUrl),
        ),
      ]),
    );
  }
}
