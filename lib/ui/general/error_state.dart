import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorText;

  const ErrorStateWidget({
    Key key,
    @required this.errorText,
  })  : assert(errorText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Icon(Icons.error, size: 100, color: Colors.redAccent),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context).serverErrorDescription,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(this.errorText, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
