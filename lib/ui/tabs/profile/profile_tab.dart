import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/components.dart';

class ProfileTab extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}
