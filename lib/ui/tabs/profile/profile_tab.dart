import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/constants.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/app_network_image.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class ProfileTab extends StatelessWidget {
  static const anonymousPhotoPath = "assets/anonymous_avatar.jpg";

  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 64),
      children: [
        BasicSection(
          children: [_buildUserProfileTile(context)],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text("Mano būklė"),
              leading: Icon(Icons.medical_services),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ROUTE_USER_CONDITIONS,
                );
              },
            ),
            AppListTile(
              title: Text("DEBUG: AuthInfo"),
              onTap: () {
                _showDebugAuthDialog(context);
              },
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text("Dažniausiai užduodami klausimai"),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.ROUTE_FAQ,
                );
              },
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text("Privatumo politika"),
              leading: Icon(Icons.lock),
              onTap: () {
                _launchURL(Constants.privacyPolicyUrl);
              },
            ),
            AppListTile(
              title: Text("Naudojimosi taisyklės"),
              leading: Icon(Icons.description),
              onTap: () {
                _launchURL(Constants.rulesUrl);
              },
            ),
          ],
        ),
        BasicSection(
          children: [
            AppListTile(
              title: Text("Atsijungti"),
              leading: Icon(Icons.logout),
              onTap: () => _signOut(context),
            ),
          ],
        ),
        FutureBuilder(
          future: _getVersionString(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Center(child: Text(snapshot.data));
            }
            return SizedBox.shrink();
          },
        )
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showDebugAuthDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: AppFutureBuilder<IdTokenResult>(
              future: _authenticationProvider.currentUser.getIdTokenResult(),
              builder: (context, data) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () => Share.share(data.token),
                          child: Text("SHARE Token")),
                      SelectableText(
                        "SignInProvider: ${data.signInProvider}\n\n"
                        "issuedAtTime: ${data.issuedAtTime}\n\n"
                        "authTime: ${data.authTime}\n\n"
                        "expirationTime: ${data.expirationTime}\n\n"
                        "signInProvider: ${data.signInProvider}\n\n"
                        "claims: ${data.claims}\n\n"
                        "Token: ${data.token}\n\n",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
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
