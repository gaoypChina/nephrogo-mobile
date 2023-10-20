import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/user_profile/user_profile_screen.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class LoginScreen extends StatelessWidget {
  final _authenticationProvider = AuthenticationProvider();
  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.contact_support_outlined),
            tooltip: context.appLocalizations.support,
            onPressed: () => showContactDialog(context),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/logo/logo-with-title.png',
              fit: BoxFit.scaleDown,
              excludeFromSemantics: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: LoginButton(
                label: Text(context.appLocalizations.loginGoogle),
                icon: Image.asset(
                  'assets/logo/google_light.png',
                  height: 24.0,
                ),
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () => _loginWithSocial(
                  context,
                  SocialAuthenticationProvider.google,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: LoginButton(
                label: Text(context.appLocalizations.loginFacebook),
                icon: const Icon(Icons.facebook),
                color: const Color(0xFF3B5998),
                onPressed: () => _loginWithSocial(
                  context,
                  SocialAuthenticationProvider.facebook,
                ),
              ),
            ),
          ),
          if (Theme.of(context).platform == TargetPlatform.iOS)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: LoginButton(
                  label: Text(context.appLocalizations.loginApple),
                  icon: Image.asset(
                    'assets/logo/apple.png',
                    height: 24.0,
                    color: Colors.white,
                  ),
                  color: Colors.black,
                  onPressed: () => _loginWithSocial(
                    context,
                    SocialAuthenticationProvider.apple,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: LoginButton(
                label: Text(context.appLocalizations.registerUsingEmail),
                icon: const Icon(Icons.email),
                color: Colors.brown,
                onPressed: () => _registerAndLoginUsingEmail(context),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.all(16),
            child: EmailLoginButtonComponent(
              onCredentialsRetrieved: (userCredential) =>
                  navigateToNextScreen(context, userCredential),
            ),
          ),
        ],
      ),
    );
  }

  Future _registerAndLoginUsingEmail(BuildContext context) async {
    final userCredential = await Navigator.pushNamed<UserCredential>(
      context,
      Routes.routeRegistration,
    );

    if (userCredential != null) {
      await navigateToNextScreen(context, userCredential);
    }
  }

  Future _loginWithSocial(
    BuildContext context,
    SocialAuthenticationProvider provider,
  ) async {
    UserCredential? userCredential;

    try {
      userCredential = await _authenticationProvider.signIn(provider);
    } on LoginCancelledException {
      developer.log(
        'Login cancelled',
      );
    } catch (e, stacktrace) {
      developer.log(
        'Unable to to to login with social',
        stackTrace: stacktrace,
        error: e,
      );

      await showAppDialog(context: context, content: Text(e.toString()));
    }

    if (userCredential != null) {
      await navigateToNextScreen(context, userCredential);
    }
  }

  Future<UserProfileV2?> getUserProfileAndUpdateUser() async {
    final user = await _apiService.getUser();
    var marketingAllowed = await _appPreferences.isMarketingAllowed();
    final selectedCountryCode = await _appPreferences.getCountryCode();

    if (!await _appPreferences.hasMarketingAllowed()) {
      marketingAllowed = user.isMarketingAllowed ?? false;
    }

    if (marketingAllowed != user.isMarketingAllowed) {
      await _apiService.updateUser(marketingAllowed: marketingAllowed);
    }

    if (selectedCountryCode != null) {
      await _apiService.selectCountry(selectedCountryCode);
    }

    await _appPreferences.setMarketingAllowed(marketingAllowed);

    final userProfile = await _apiService.getUserProfile().then((r) => r.data);

    await _appPreferences.setDialysisType(userProfile?.dialysis);

    return userProfile;
  }

  Future navigateToNextScreen(
    BuildContext context,
    UserCredential userCredential,
  ) async {
    final userProfile = await AppProgressDialog.showForFuture(
      context,
      getUserProfileAndUpdateUser(),
    );

    if (userProfile != null) {
      await _appPreferences.setProfileCreated();

      return Navigator.pushReplacementNamed(
        context,
        Routes.routeHome,
      );
    }

    return Navigator.pushReplacementNamed(
      context,
      Routes.routeUserProfile,
      arguments: UserProfileNextScreenType.homeScreen,
    );
  }
}

class EmailLoginButtonComponent extends StatelessWidget {
  final void Function(UserCredential userCredential) onCredentialsRetrieved;

  const EmailLoginButtonComponent({
    super.key,
    required this.onCredentialsRetrieved,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appLocalizations.alreadyRegisterWhenLogin,
          style: const TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: () => _onLoginPressed(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(width: 2, color: Colors.white),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                appLocalizations.loginEmail.toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _onLoginPressed(BuildContext context) async {
    final userCredential = await Navigator.pushNamed<UserCredential>(
      context,
      Routes.routeLoginEmailPassword,
    );

    if (userCredential != null) {
      onCredentialsRetrieved(userCredential);
    }
  }
}
