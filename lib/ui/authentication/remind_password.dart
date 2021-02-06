import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';

class RemindPasswordScreen extends StatefulWidget {
  @override
  _RemindPasswordScreenState createState() => _RemindPasswordScreenState();
}

class _RemindPasswordScreenState extends State<RemindPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _authProvider = AuthenticationProvider();

  String email;

  @override
  Widget build(BuildContext context) {
    final formValidators = FormValidators(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.passwordRecovery),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BasicSection(
              innerPadding: const EdgeInsets.symmetric(vertical: 8),
              header: AppListTile(
                leading: const CircleAvatar(child: Icon(Icons.info_outline)),
                title: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    appLocalizations.passwordRecoveryInstructions,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
            BasicSection(
              children: [
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        AppTextFormField(
                          labelText: appLocalizations.email,
                          autoFocus: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: formValidators.nonEmptyValidator,
                          autofillHints: const [AutofillHints.email],
                          iconData: Icons.alternate_email,
                          textInputAction: TextInputAction.next,
                          onSaved: (s) => email = s,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: AppElevatedButton(
                              text: appLocalizations.confirm,
                              onPressed: () => _remindPassword(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _remindPassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _authProvider.sendPasswordResetEmail(email);

        await showAppDialog(
          context: context,
          message: appLocalizations.passwordRecoveryEmailSent(email),
        );

        Navigator.pop(context);
      } catch (e, stacktrace) {
        developer.log(
          'Unable to remind password',
          stackTrace: stacktrace,
        );

        await showAppDialog(context: context, message: e.toString());
      }
    }
  }
}
