import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorText;

  const ErrorStateWidget({
    Key? key,
    required this.errorText,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(errorText, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
