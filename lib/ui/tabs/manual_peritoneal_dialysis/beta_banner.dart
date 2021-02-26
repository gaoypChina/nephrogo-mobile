import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';

class BetaBanner extends StatefulWidget {
  @override
  _BetaBannerState createState() => _BetaBannerState();
}

class _BetaBannerState extends State<BetaBanner> {
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showBanner,
      child: BasicSection.single(
        MaterialBanner(
          backgroundColor: Colors.white,
          leading: const CircleAvatar(child: Icon(Icons.announcement)),
          content: Text(appLocalizations.manualDialysisBetaDisclaimer),
          actions: <Widget>[
            TextButton(
              onPressed: () => launchEmail(Constants.supportEmail),
              child: Text(
                appLocalizations.feedback.toUpperCase(),
              ),
            ),
            TextButton(
              onPressed: () => setState(() {
                showBanner = false;
              }),
              child: Text(appLocalizations.ok.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
