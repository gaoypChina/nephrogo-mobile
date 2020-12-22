import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/buttons.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/dialogs.dart';

import 'login_conditions.dart';

class EmailPasswordLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prisijunkite"),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          showDividers: false,
          children: [
            _RegularLoginForm(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppElevatedButton(
                  text: "Registracija",
                  onPressed: () => _openRegistration(context),
                  color: Colors.grey,
                  textColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text("PAMIRŠOTE SLAPTAŽODĮ?"),
                  onPressed: () => _openRemindPassword(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                  child: LoginConditionsRichText(textColor: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Future _openRemindPassword(BuildContext context) {
    return Navigator.of(context).pushNamed(Routes.ROUTE_REMIND_PASSWORD);
  }

  Future _openRegistration(BuildContext context) async {
    UserCredential userCredential =
        await Navigator.of(context).pushNamed(Routes.ROUTE_REGISTRATION);

    if (userCredential != null) {
      Navigator.of(context).pop(userCredential);
    }
  }
}

class _RegularLoginForm extends StatefulWidget {
  @override
  _RegularLoginFormState createState() => _RegularLoginFormState();
}

class _RegularLoginFormState extends State<_RegularLoginForm> {
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
                  text: "Prisijungti",
                  onPressed: () => _login(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      UserCredential userCredential;

      try {
        userCredential =
        await _authProvider.signInWithEmailAndPassword(email, password);
      } on UserNotFoundException catch (_) {
        await showAppDialog(
          context: context,
          title: "Klaida",
          message: "Toks vartotojas neegzistuoja.",
        );
      } on InvalidPasswordException catch (_) {
        await showAppDialog(
          context: context,
          title: "Klaida",
          message: "Neteisingas slaptažodis.",
        );
      } catch (e, stacktrace) {
        developer.log(
          "Unable to to to login using regular login",
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
