import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.registration)),
      body: SingleChildScrollView(
        child: BasicSection.single(
          innerPadding: const EdgeInsets.symmetric(vertical: 8),
          child: _RegistrationForm(),
        ),
      ),
    );
  }
}

class _RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<_RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _authProvider = AuthenticationProvider();

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return AppForm(
      formKey: _formKey,
      save: () => _register(context),
      child: AutofillGroup(
        child: Column(
          children: [
            AppTextFormField(
              labelText: appLocalizations.email,
              autoFocus: true,
              keyboardType: TextInputType.emailAddress,
              validator: formValidators.nonEmptyValidator,
              autofillHints: const [AutofillHints.email],
              prefixIcon: const Icon(Icons.alternate_email),
              textInputAction: TextInputAction.next,
              onSaved: (s) => email = s,
            ),
            AppTextFormField(
              labelText: appLocalizations.password,
              obscureText: true,
              validator: formValidators.and(
                formValidators.nonNull(),
                formValidators.lengthValidator(6),
              ),
              autofillHints: const [AutofillHints.password],
              prefixIcon: const Icon(Icons.lock),
              onSaved: (s) => password = s,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: AppElevatedButton(
                  text: appLocalizations.register,
                  onPressed: () => _register(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      UserCredential userCredential;

      try {
        userCredential =
            await _authProvider.createUserWithEmailAndPassword(email, password);
      } on EmailAlreadyInUseException catch (_) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          content: Text(appLocalizations.errorEmailAlreadyInUse),
        );
      } on InvalidEmailException catch (_) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          content: Text(appLocalizations.errorInvalidEmail),
        );
      } on WeakPasswordException catch (_) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          content: Text(appLocalizations.errorWeakPassword),
        );
      } catch (e, stacktrace) {
        developer.log(
          'Unable to to to register',
          stackTrace: stacktrace,
        );
        await showAppDialog(context: context, content: Text(e.toString()));
      }

      if (userCredential != null) {
        Navigator.of(context).pop(userCredential);
        return true;
      }
    }
    return false;
  }
}
