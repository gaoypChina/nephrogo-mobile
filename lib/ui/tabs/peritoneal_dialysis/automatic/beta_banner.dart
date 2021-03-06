import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';

class BetaBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicSection.single(
      child: MaterialBanner(
        leading: const CircleAvatar(child: Icon(Icons.announcement)),
        content: Text(context.appLocalizations.automaticDialysisBetaDisclaimer),
        forceActionsBelow: true,
        actions: <Widget>[
          TextButton(
            onPressed: () => launchEmail(Constants.supportEmail),
            child: Text(context.appLocalizations.feedback.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
