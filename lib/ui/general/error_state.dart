import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';

import 'dialogs.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorText;
  final void Function()? retry;

  const ErrorStateWidget({
    Key? key,
    required this.errorText,
    this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Icon(Icons.error, size: 100, color: Colors.redAccent),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              context.appLocalizations.serverErrorDescription,
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          if (retry != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: ElevatedButton(
                onPressed: retry,
                child: Text(context.appLocalizations.tryAgain.toUpperCase()),
              ),
            ),
          OutlinedButton(
            onPressed: () => showContactDialog(context),
            child: Text(context.appLocalizations.support.toUpperCase()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SelectableText(errorText, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
