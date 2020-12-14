import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/general/app_network_image.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class ProfileTab extends StatelessWidget {
  static const privacyPolicyUrl =
      "https://www.nephrolog.lt/privatumo-politika/";
  static const rulesUrl = "https://www.nephrolog.lt/privatumo-politika/";

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
                _launchURL(privacyPolicyUrl);
              },
            ),
            AppListTile(
              title: Text("Naudojimosi taisyklės"),
              leading: Icon(Icons.description),
              onTap: () {
                _launchURL(rulesUrl);
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

    return AppListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 64,
          height: 64,
          child: getUserProfilePhoto(),
        ),
      ),
      title: Text(
        user.displayName,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(user.email),
    );
  }
}
