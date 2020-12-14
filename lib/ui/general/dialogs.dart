import 'package:flutter/material.dart';

Future showErrorDialog({
  @required BuildContext context,
  @required String message,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Klaida"),
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
