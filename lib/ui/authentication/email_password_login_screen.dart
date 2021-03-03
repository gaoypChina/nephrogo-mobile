import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';

class EmailPasswordLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.login)),
      body: SingleChildScrollView(
        child: BasicSection(
          innerPadding: const EdgeInsets.only(top: 8),
          children: [
            _RegularLoginForm(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextButton(
                  onPressed: () => _openRemindPassword(context),
                  child: Text(appLocalizations.forgetPassword.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openRemindPassword(BuildContext context) {
    return Navigator.of(context).pushNamed(Routes.routeRemindPassword);
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
    return AppForm(
      formKey: _formKey,
      save: () => _login(context),
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
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: AppElevatedButton(
                  text: appLocalizations.loginAction,
                  onPressed: () => _login(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      UserCredential userCredential;

      try {
        userCredential =
            await _authProvider.signInWithEmailAndPassword(email, password);
      } on UserNotFoundException catch (_) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          message: appLocalizations.errorUserNotFound,
        );
      } on InvalidPasswordException catch (_) {
        await showAppDialog(
          context: context,
          title: appLocalizations.error,
          message: appLocalizations.errorInvalidPassword,
        );
      } catch (e, stacktrace) {
        developer.log(
          'Unable to to to login using regular login',
          stackTrace: stacktrace,
        );
        await showAppDialog(context: context, message: e.toString());
      }

      if (userCredential != null) {
        Navigator.of(context).pop(userCredential);
        return true;
      }
    }

    return false;
  }
}
