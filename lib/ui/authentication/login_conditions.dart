import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginConditionsRichText extends StatelessWidget {
  final Color textColor;

  const LoginConditionsRichText({Key key, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "Prisijungdami Jūs patvirtinate, kad sutinkate su\n",
          style: TextStyle(color: textColor),
        ),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          text: "Privatumo poltika",
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Constants.privacyPolicyUrl),
        ),
        TextSpan(
            text: " ir ",
            style: TextStyle(
              color: textColor,
            )),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          text: "Naudojimosi taisyklėmis",
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Constants.rulesUrl),
        ),
      ]),
    );
  }

  Future launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
