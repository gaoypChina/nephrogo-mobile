import 'package:flutter/material.dart';

Future showAppDialog({
  @required BuildContext context,
  @required String message,
  String title,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(
          message,
        ),
        actions: [
          TextButton(
            child: Text('Gerai'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
