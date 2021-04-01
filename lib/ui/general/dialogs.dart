import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/utils/utils.dart';

import 'components.dart';

Future<void> showAppDialog({
  required BuildContext context,
  required Widget content,
  String title,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        scrollable: true,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.appLocalizations.ok.toUpperCase()),
          ),
        ],
      );
    },
  );
}

Future<void> showAppErrorDialog({
  required BuildContext context,
  required String message,
}) async {
  final showHelp = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(context.appLocalizations.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(context.appLocalizations.help.toUpperCase()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(context.appLocalizations.ok.toUpperCase()),
          ),
        ],
      );
    },
  ).then((v) => v ?? false);

  if (showHelp) {
    await showContactDialog(context);
  }
}

Future<void> showContactDialog(BuildContext context) {
  final appLocalizations = context.appLocalizations;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 16,
              ),
              title: Text(appLocalizations.supportEmail),
              leading: const Icon(Icons.email),
              onTap: () => launchEmail(Constants.supportEmail),
            ),
            AppListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              title: Text(appLocalizations.supportPhone),
              leading: const Icon(Icons.phone),
              onTap: () => launchPhone(Constants.supportPhone),
            ),
          ],
        ),
      );
    },
  );
}

Future<bool> showDeleteDialog({
  required BuildContext context,
  required Future<void> Function() onDelete,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(context.appLocalizations.delete),
        content: Text(context.appLocalizations.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.appLocalizations.dialogCancel.toUpperCase()),
          ),
          TextButton(
            onPressed: () async {
              await ProgressDialog(context).showForFuture(onDelete());

              Navigator.of(context).pop(true);
            },
            child: Text(context.appLocalizations.delete.toUpperCase()),
          ),
        ],
      );
    },
  ).then((r) => r ?? false);
}
