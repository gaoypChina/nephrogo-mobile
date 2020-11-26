import 'package:flutter/material.dart';

import 'tabs/settings_tab.dart';
import 'tabs/nutrition_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nephrolog"),
        centerTitle: true,
      ),
      body: getTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.restaurant_outlined),
            label: "Mityba",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.analytics_outlined),
            label: "Rodikliai",
            // label: AppLocalizations.of(context).tabIndicators,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: "Nustatymai",
          ),
        ],
      ),
    );
  }

  Widget getTabBody() {
    switch (_currentIndex) {
      case 0:
        return NutritionTab();
      case 1:
        return NutritionTab();
      case 2:
        return SettingsTab();
      default:
        throw ArgumentError("Tab with index $_currentIndex doesn't exist");
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
