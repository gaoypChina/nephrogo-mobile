import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:nephrogo/extensions/extensions.dart';

class AppProgressDialog {
  AppProgressDialog._();

  static Future<T> showForFuture<T>(BuildContext context, Future<T> future) {
    showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        future,
        message: Text(context.appLocalizations.pleaseWait),
      ),
    );

    return future;
  }
}
