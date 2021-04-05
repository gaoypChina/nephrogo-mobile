import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/general/progress_indicator.dart';

class AppProgressDialog {
  late ProgressDialog dialog;

  AppProgressDialog(BuildContext context) {
    dialog = ProgressDialog(
      context,
      backgroundColor: const Color(0x33000000),
      defaultLoadingWidget: const AppProgressIndicator(),
      dismissable: false,
    );
  }

  Future<T> showForFuture<T>(Future<T> future) async {
    try {
      show();

      return await future;
    } finally {
      dismiss();
    }
  }

  void show() {
    dialog.show();
  }

  void dismiss() {
    dialog.dismiss();
  }
}
