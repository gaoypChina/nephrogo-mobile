import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class AppProgressDialog {
  late ProgressDialog dialog;
  late String message;

  AppProgressDialog(BuildContext context) {
    message = context.appLocalizations.pleaseWait;
    dialog = ProgressDialog(
      context: context,
    );
  }

  Future<T> showForFuture<T>(Future<T> future) {
    show();

    return future.whenComplete(() => dismiss());
  }

  void show() {
    dialog.show(
      backgroundColor: const Color(0x33000000),
      msg: message,
      barrierDismissible: true,
    );
  }

  void dismiss() {
    dialog.close();
  }
}
