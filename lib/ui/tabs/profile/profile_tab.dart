import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/general/app_network_image.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class ProfileTab extends StatelessWidget {
  static const privacyPolicyUrl =
      "https://www.nephrolog.lt/privatumo-politika/";
  static const rulesUrl = "https://www.nephrolog.lt/privatumo-politika/";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 64),
      children: [
        BasicSection(
          children: [
            AppListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 64,
                  height: 64,
                  child: getUserProfilePhoto(),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  "Karolis Vyčius",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle: Flex(
                direction: Axis.horizontal,
                children: [
                  TextButton(
                    child: Text(
                      "Atsijungti",
                      style: TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.start,
                    ),
                    onPressed: () => print("Logout"),
                  ),
                ],
              ),
            ),
          ],
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

  Widget getUserProfilePhoto() {
    return AppNetworkImage(
      url:
          "https://avatars2.githubusercontent.com/u/3719141?s=460&u=93b7989bcf06fcc23144917944203f315c3d4134&v=4",
      fallbackAssetImage: "assets/anonymous_avatar.jpg",
    );
  }

  Future<String> _getVersionString() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return "${packageInfo.version} (${packageInfo.buildNumber})";
  }
}
