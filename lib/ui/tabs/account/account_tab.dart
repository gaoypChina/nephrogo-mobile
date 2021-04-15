import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/debug/debug_list_cell.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/app_network_image.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/legal/legal_screen.dart';
import 'package:nephrogo/ui/onboarding/onboarding_screen.dart';
import 'package:nephrogo/ui/user_profile/user_profile_screen.dart';
import 'package:nephrogo/utils/app_store_utils.dart';
import 'package:nephrogo/utils/utils.dart';
import 'package:package_info/package_info.dart';

class AccountTab extends StatelessWidget {
  static const anonymousPhotoPath = 'assets/anonymous_avatar.jpg';

  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return Scrollbar(
      child: ListView(
        children: [
          BasicSection.single(child: _buildUserProfileTile(context)),
          BasicSection.single(
            child: AppListTile(
              title: Text(appLocalizations.userProfileScreenTitle),
              leading: const Icon(Icons.account_box),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.routeUserProfile,
                arguments: UserProfileNextScreenType.close,
              ),
            ),
          ),
          BasicSection(
            showDividers: true,
            children: [
              AppListTile(
                title: Text(appLocalizations.termsOfUse),
                leading: const Icon(Icons.description),
                onTap: () => _navigateToTermsOfUse(context),
              ),
              AppListTile(
                title: Text(appLocalizations.onboarding),
                leading: const Icon(Icons.explore),
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.routeOnboarding,
                  arguments:
                      OnboardingScreenArguments(OnboardingScreenExitType.close),
                ),
              ),
            ],
          ),
          BasicSection.single(
            child: AppListTile(
              title: Text(appLocalizations.reportMissingProduct),
              leading: const Icon(Icons.feedback),
              onTap: () => launchURL(Constants.reportMissingProductUrl),
            ),
          ),
          BasicSection.single(
            child: AppListTile(
              title: Text(appLocalizations.rateApp),
              leading: const Icon(Icons.rate_review),
              onTap: () => AppReview().openStoreListing(),
            ),
          ),
          BasicSection(
            showDividers: true,
            children: [
              AppListTile(
                title: Text(appLocalizations.supportPhone),
                leading: const Icon(Icons.call),
                onTap: () => launchPhone(Constants.supportPhone),
              ),
              AppListTile(
                title: Text(appLocalizations.supportEmail),
                leading: const Icon(Icons.email),
                onTap: () => launchEmail(Constants.supportEmail),
              ),
            ],
          ),
          if (kDebugMode) BasicSection.single(child: DebugListCell()),
          BasicSection.single(
            child: AppListTile(
              title: Text(appLocalizations.logout),
              leading: const Icon(Icons.logout),
              onTap: () => _signOut(context),
            ),
          ),
          AppFutureBuilder<String>(
            future: () => _getVersionString(),
            builder: (context, version) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Center(child: Text(version)),
              );
            },
          )
        ],
      ),
    );
  }

  Future _navigateToTermsOfUse(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeLegal,
      arguments: const LegalScreenArguments(LegalScreenExitType.close),
    );
  }

  Future _signOut(BuildContext context) async {
    await _authenticationProvider.signOut();

    await Navigator.pushReplacementNamed(
      context,
      Routes.routeStart,
    );
  }

  Widget getUserProfilePhoto() {
    final photoURL = _authenticationProvider.currentUserPhotoURL;
    if (photoURL == null) {
      return Image.asset(
        anonymousPhotoPath,
        excludeFromSemantics: true,
      );
    }

    return AppNetworkImage(
      url: photoURL,
      fallbackAssetImage: anonymousPhotoPath,
    );
  }

  Future<String> _getVersionString() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }

  Widget _buildUserProfileTile(BuildContext context) {
    final user = _authenticationProvider.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 64,
            height: 64,
            child: getUserProfilePhoto(),
          ),
        ),
        title: Text(
          user?.displayName ?? user?.email ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: user?.displayName != null ? Text(user?.email ?? '') : null,
      ),
    );
  }
}
