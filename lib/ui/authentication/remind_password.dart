import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/buttons.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/dialogs.dart';
import 'dart:developer' as developer;


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
    return Scaffold(
      appBar: AppBar(
        title: Text("Slaptažodžio atkūrimas"),
      ),
      body: ListView(
        children: [
          BasicSection(
            header: AppListTile(
              leading: IconButton(
                icon: Icon(Icons.info),
                onPressed: null,
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "Įveskite savo elektroninio pašto adresą ir atsiūsime "
                  "Jums laišką su instrukcijomis, kaip pakeisti slaptažodį.",
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          BasicSection(
            showDividers: false,
            children: [
              Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    children: [
                      AppTextFormField(
                        labelText: "El. paštas",
                        autoFocus: true,
                        keyboardType: TextInputType.emailAddress,
                        validator: FormValidators.nonEmptyValidator,
                        autofillHints: [AutofillHints.email],
                        iconData: Icons.alternate_email,
                        textInputAction: TextInputAction.next,
                        onSaved: (s) => email = s,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                          child: AppElevatedButton(
                            text: "Patvirtinti",
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
    );
  }

  Future _remindPassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        await _authProvider.sendPasswordResetEmail(email);

        await showAppDialog(
          context: context,
          message: "Išsiuntėme laišką slaptažodžiui pakeisti į $email",
        );

        Navigator.pop(context);
      } catch (e, stacktrace) {
        developer.log(
          "Unable to remind password",
          stackTrace: stacktrace,
        );

        await showAppDialog(context: context, message: e.toString());
      }
    }
  }
}
