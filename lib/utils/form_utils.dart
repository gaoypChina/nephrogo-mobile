import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';

class FormUtils {
  FormUtils._();

  static Future<bool> validate({
    @required BuildContext context,
    @required GlobalKey<FormState> formKey,
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

    return true;
  }

  static Future<bool> validateAndSave({
    @required BuildContext context,
    @required GlobalKey<FormState> formKey,
    @required Future Function() futureBuilder,
    String Function(String data) onServerValidationError,
    Future<void> Function() onSuccess,
  }) async {
    final valid = await validate(context: context, formKey: formKey);
    if (!valid) {
      return false;
    }

    formKey.currentState.save();

    final future = futureBuilder().catchError(
          (e, stackTrace) async {
        FirebaseCrashlytics.instance.recordError(e, stackTrace as StackTrace);

        String message;
        if (e is DioError && e.response?.statusCode == 400) {
          final data = e.response?.toString() ?? '';

          if (onServerValidationError != null) {
            message = onServerValidationError(data);
          }
        }

        await showAppDialog(
          context: context,
          title: context.appLocalizations.error,
          message: message ?? context.appLocalizations.serverErrorDescription,
        );
      },
    );

    final res = await ProgressDialog(context).showForFuture(future);

    if (res != null) {
      if (onSuccess != null) {
        await onSuccess();
      } else {
        Navigator.of(context).pop();
      }

      return true;
    }
    return false;
  }
}
