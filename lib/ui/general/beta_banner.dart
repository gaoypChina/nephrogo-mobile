import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';

class BetaBanner extends StatefulWidget {
  @override
  _BetaBannerState createState() => _BetaBannerState();
}

class _BetaBannerState extends State<BetaBanner> {
  var showBanner = true;

  Future<void> _showHelpDialog(AppLocalizations appLocalizations) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text(appLocalizations.supportEmail),
                onTap: () => launchEmail(Constants.supportEmail),
              ),
              AppListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text(appLocalizations.supportPhone),
                onTap: () => launchPhone(Constants.supportPhone),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Visibility(
      visible: showBanner,
      child: MaterialBanner(
        backgroundColor: Colors.white,
        leading: CircleAvatar(child: Icon(Icons.announcement)),
        content: Text(appLocalizations.betaDisclaimer),
        actions: <Widget>[
          FlatButton(
            child: Text(
              appLocalizations.help.toUpperCase(),
            ),
            onPressed: () => _showHelpDialog(appLocalizations),
          ),
          FlatButton(
            child: Text(appLocalizations.ok.toUpperCase()),
            onPressed: () => setState(() {
              showBanner = false;
            }),
          ),
        ],
      ),
    );
  }
}
