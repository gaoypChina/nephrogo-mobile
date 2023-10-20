import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:nephrogo/extensions/extensions.dart';

class AppProgressDialog {
  AppProgressDialog._();

  static Future<T> showForFuture<T>(BuildContext context, Future<T> future) {
    showFutureLoadingDialog(
      context: context,
      title: context.appLocalizations.pleaseWait,
      future: () => future,
    );

    return future;
  }
}
