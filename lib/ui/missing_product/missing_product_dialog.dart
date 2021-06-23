import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class MissingProductDialog extends StatefulWidget {
  @override
  _MissingProductDialogState createState() => _MissingProductDialogState();
}

class _MissingProductDialogState extends State<MissingProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  final _builder = MissingProductRequestBuilder();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.appLocalizations.reportMissingProduct),
      scrollable: true,
      content: _buildContent(context),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(context.appLocalizations.dialogCancel.toUpperCase()),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(context.appLocalizations.report.toUpperCase()),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final formValidators = FormValidators(context);

    return AppForm(
      formKey: _formKey,
      save: () => _submit(),
      child: AppTextFormField(
        textCapitalization: TextCapitalization.sentences,
        labelText: appLocalizations.message,
        autoFocus: true,
        minLines: 2,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        validator: formValidators.nonEmptyValidator,
        onSaved: (s) => _builder.message = s,
      ),
    );
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _saveToApi,
    );
  }

  Future<void> _saveToApi() {
    return _apiService.createMissingProduct(_builder.build());
  }
}
