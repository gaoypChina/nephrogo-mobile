import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/general/progress_indicator.dart';

class ProgressDialog {
  ArsProgressDialog dialog;

  ProgressDialog(BuildContext context) {
    dialog = ArsProgressDialog(
      context,
      blur: 2,
      backgroundColor: const Color(0x33000000),
      loadingWidget: const AppProgressIndicator(),
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
