import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/app_network_image.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/user_profile_screen.dart';
import 'package:nephrogo/utils/utils.dart';
import 'package:package_info/package_info.dart';

class ProfileTab extends StatelessWidget {
  static const anonymousPhotoPath = "assets/anonymous_avatar.jpg";

  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return ListView(
      children: [
        BasicSection(
          children: [_buildUserProfileTile(context)],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text(appLocalizations.userProfileScreenTitle),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ROUTE_USER_PROFILE,
                  arguments: UserProfileNextScreenType.close,
                );
              },
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text(appLocalizations.faqTitle),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ROUTE_FAQ,
                );
              },
            ),
            AppListTile(
              title: Text(appLocalizations.onboarding),
              leading: Icon(Icons.directions),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ROUTE_ONBOARDING,
                );
              },
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text(appLocalizations.privacyPolicy),
              leading: Icon(Icons.lock),
              onTap: () => launchURL(Constants.privacyPolicyUrl),
            ),
            AppListTile(
              title: Text(appLocalizations.usageRules),
              leading: Icon(Icons.description),
              onTap: () => launchURL(Constants.rulesUrl),
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text(appLocalizations.supportPhone),
              leading: Icon(Icons.call),
              onTap: () => launchPhone(Constants.supportPhone),
            ),
            AppListTile(
              title: Text(appLocalizations.supportEmail),
              leading: Icon(Icons.email),
              onTap: () => launchEmail(Constants.supportEmail),
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text(appLocalizations.logout),
              leading: Icon(Icons.logout),
              onTap: () => _signOut(context),
            ),
          ],
        ),
        AppFutureBuilder<String>(
          future: _getVersionString(),
          builder: (context, version) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
              child: Center(child: Text(version)),
            );
          },
        )
      ],
    );
  }

  Future _signOut(BuildContext context) async {
    await _authenticationProvider.signOut();

    await Navigator.pushReplacementNamed(
      context,
      Routes.ROUTE_LOGIN,
    );
  }

  Widget getUserProfilePhoto() {
    final photoURL = _authenticationProvider.currentUserPhotoURL;
    if (photoURL == null) {
      return Image.asset(anonymousPhotoPath);
    }

    return AppNetworkImage(
      url: photoURL,
      fallbackAssetImage: anonymousPhotoPath,
    );
  }

  Future<String> _getVersionString() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return "${packageInfo.version} (${packageInfo.buildNumber})";
  }

  Widget _buildUserProfileTile(BuildContext context) {
    final user = _authenticationProvider.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 64,
            height: 64,
            child: getUserProfilePhoto(),
          ),
        ),
        title: Text(
          user.displayName ?? user.email,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: user.displayName != null ? Text(user.email) : null,
      ),
    );
  }
}
