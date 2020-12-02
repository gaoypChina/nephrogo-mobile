import 'package:flutter/material.dart';

import 'app_logo.dart';
import 'tabs/health_indicators/health_indicators_tab.dart';
import 'tabs/profile/profile_tab.dart';
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
        title: AppLogo(),
        centerTitle: true,
      ),
      body: getTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_outlined),
            label: "Mityba",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            label: "Rodikliai",
            // label: AppLocalizations.of(context).tabIndicators,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Paskyra",
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
        return HealthIndicatorsTab();
      case 2:
        return ProfileTab();
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
