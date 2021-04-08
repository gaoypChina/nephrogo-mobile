import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';

class AppProgressDialog {
  late ProgressDialog dialog;

  AppProgressDialog(BuildContext context) {
    dialog = ProgressDialog(
      context,
      backgroundColor: const Color(0x33000000),
      message: Text(context.appLocalizations.pleaseWait),
      dismissable: true,
    );
  }

  Future<T> showForFuture<T>(Future<T> future) {
    show();

    return future.whenComplete(() => dismiss());
  }

  void show() {
    dialog.show();
  }

  void dismiss() {
    dialog.dismiss();
  }
}
