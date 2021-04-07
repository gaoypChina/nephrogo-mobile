import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/utils/utils.dart';

class FormUtils {
  FormUtils._();

  static Future<bool> validate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) {
      await showAppDialog(
        context: context,
        title: context.appLocalizations.error,
        content: Text(context.appLocalizations.formErrorDescription),
      );

      return false;
    }

    return true;
  }

  static Future<bool> validateAndSave({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required Future Function() futureBuilder,
    String Function(String data)? onServerValidationError,
    Future<void> Function()? onSuccess,
  }) async {
    final valid = await validate(context: context, formKey: formKey);
    if (!valid) {
      return false;
    }

    formKey.currentState!.save();

    return ApiUtils.saveToApi(
      context: context,
      futureBuilder: futureBuilder,
      onServerValidationError: onServerValidationError,
      onSuccess: onSuccess,
    );
  }
}
