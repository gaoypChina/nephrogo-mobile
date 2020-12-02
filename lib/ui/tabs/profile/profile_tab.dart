import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ProfileCell(
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
            ),
            ProfileCell(
              title: Text("Mano būklė"),
              leading: Icon(Icons.quick_contacts_dialer),
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
      ),
    );
  }
}

class ProfileCell extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final GestureTapCallback onTap;

  const ProfileCell({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
