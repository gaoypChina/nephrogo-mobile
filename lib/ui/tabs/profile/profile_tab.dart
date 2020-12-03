import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class ProfileTab extends StatelessWidget {
  static const privacyPolicyUrl =
      "https://www.nephrolog.lt/privatumo-politika/";
  static const rulesUrl = "https://www.nephrolog.lt/privatumo-politika/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BasicSection(
              children: [
                AppListTile(
                  leading: Container(
                    width: 64,
                    height: 64,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://avatars2.githubusercontent.com/u/3719141?s=460&u=93b7989bcf06fcc23144917944203f315c3d4134&v=4",
                      ),
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
                  trailing: Icon(Icons.chevron_right),
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
                  title: Text("Privatumo politika"),
                  leading: Icon(Icons.lock),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    _launchURL(privacyPolicyUrl);
                  },
                ),
                AppListTile(
                  title: Text("Naudojimosi taisyklės"),
                  leading: Icon(Icons.description),
                  trailing: Icon(Icons.chevron_right),
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
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> _getVersionString() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return "${packageInfo.version} (${packageInfo.buildNumber})";
  }
}
