import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';

class FormUtils {
  FormUtils._();

  static Future<bool> validateAndSave({
    @required BuildContext context,
    @required GlobalKey<FormState> formKey,
    @required Future Function() futureBuilder,
  }) async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState.validate()) {
      await showAppDialog(
        context: context,
        title: context.appLocalizations.error,
        message: context.appLocalizations.formErrorDescription,
      );

      return false;
    }

    formKey.currentState.save();

    final future = futureBuilder().catchError(
      (e, stackTrace) async {
        await showAppDialog(
          context: context,
          title: context.appLocalizations.error,
          message: context.appLocalizations.serverErrorDescription,
        );
      },
    );

    final res = await ProgressDialog(context).showForFuture(future);

    if (res != null) {
      Navigator.of(context).pop();

      return true;
    }
    return false;
  }
}
