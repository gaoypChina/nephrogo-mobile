import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';

import 'login_conditions.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paskyros sukūrimas'),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          showDividers: false,
          children: [
            _RegistrationForm(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                  child: LoginConditionsRichText(textColor: Colors.black)),
            ),
          ],
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
    final formValidators = FormValidators(context);

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            AppTextFormField(
              labelText: 'El. paštas',
              autoFocus: true,
              keyboardType: TextInputType.emailAddress,
              validator: formValidators.nonEmptyValidator,
              autofillHints: const [AutofillHints.email],
              iconData: Icons.alternate_email,
              textInputAction: TextInputAction.next,
              onSaved: (s) => email = s,
            ),
            AppTextFormField(
              labelText: 'Slaptažodis',
              obscureText: true,
              validator: formValidators.and(
                formValidators.nonNull(),
                formValidators.lengthValidator(6),
              ),
              autofillHints: const [AutofillHints.password],
              iconData: Icons.lock,
              onSaved: (s) => password = s,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: AppElevatedButton(
                  text: 'Sukurti paskyrą',
                  onPressed: () => _register(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      UserCredential userCredential;

      try {
        userCredential =
            await _authProvider.createUserWithEmailAndPassword(email, password);
      } on EmailAlreadyInUseException catch (_) {
        await showAppDialog(
          context: context,
          message: 'Toks vartotojas jau registruotas.',
        );
      } on InvalidEmailException catch (_) {
        await showAppDialog(
          context: context,
          message: 'Blogas elektroninio pašto adresas.',
        );
      } on WeakPasswordException catch (_) {
        await showAppDialog(
          context: context,
          message: 'Per silpnas slaptažodis.',
        );
      } catch (e, stacktrace) {
        developer.log(
          'Unable to to to register',
          stackTrace: stacktrace,
        );
        await showAppDialog(context: context, message: e.toString());
      }

      if (userCredential != null) {
        Navigator.of(context).pop(userCredential);
      }
    }
  }
}
