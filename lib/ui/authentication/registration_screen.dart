import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/buttons.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/dialogs.dart';

import 'login_conditions.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paskyros sukūrimas"),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          showDividers: false,
          children: [
            _RegistrationForm(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
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
              labelText: "El. paštas",
              autoFocus: true,
              keyboardType: TextInputType.emailAddress,
              validator: formValidators.nonEmptyValidator,
              autofillHints: [AutofillHints.email],
              iconData: Icons.alternate_email,
              textInputAction: TextInputAction.next,
              onSaved: (s) => email = s,
            ),
            AppTextFormField(
              labelText: "Slaptažodis",
              obscureText: true,
              validator: formValidators.lengthValidator(6),
              autofillHints: [AutofillHints.password],
              iconData: Icons.lock,
              onSaved: (s) => password = s,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: AppElevatedButton(
                  text: "Sukurti paskyrą",
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
        showAppDialog(
          context: context,
          message: "Toks vartotojas jau registruotas.",
        );
      } on InvalidEmailException catch (_) {
        showAppDialog(
          context: context,
          message: "Blogas elektroninio pašto adresas.",
        );
      } on WeakPasswordException catch (_) {
        showAppDialog(
          context: context,
          message: "Per silpnas slaptažodis.",
        );
      } catch (e, stacktrace) {
        developer.log(
          "Unable to to to register",
          stackTrace: stacktrace,
        );
        showAppDialog(context: context, message: e.toString());
      }

      if (userCredential != null) {
        Navigator.of(context).pop(userCredential);
      }
    }
  }
}
