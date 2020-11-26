import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
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
    );
  }
}
