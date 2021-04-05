import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';

class AppForm extends StatefulWidget {
  final Widget child;
  final VoidCallback? onChanged;
  final GlobalKey<FormState> formKey;
  final Future<bool> Function() save;

  const AppForm({
    required this.child,
    required this.formKey,
    required this.save,
    this.onChanged,
  }) : super();

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  bool _isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      onWillPop: _onWillPop,
      onChanged: () {
        _isChanged = true;

        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      },
      child: widget.child,
    );
  }

  Future<bool> _onWillPop() async {
    if (!_isChanged) {
      return true;
    }

    final shouldSave = await _showChangesNotSavedDialog();

    if (shouldSave == null) {
      return false;
    } else if (shouldSave) {
      await widget.save();
      return false;
    } else {
      return true;
    }
  }

  Future<bool?> _showChangesNotSavedDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(context.appLocalizations.formChangesNotSaved),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.appLocalizations.discard.toUpperCase()),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(context.appLocalizations.save.toUpperCase()),
            ),
          ],
        );
      },
    );
  }
}
