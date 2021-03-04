import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/utils/app_store_utils.dart';

import 'general/app_bar_logo.dart';
import 'tabs/account/account_tab.dart';
import 'tabs/health_status/health_status_tab.dart';
import 'tabs/nutrition/nutrition_tab.dart';
import 'tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _appReview = AppReview();
  int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _appReview.requestReviewConditionally(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarLogo(),
        centerTitle: true,
      ),
      body: getTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_outlined),
            label: AppLocalizations.of(context).tabNutrition,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            label: AppLocalizations.of(context).tabHealthIndicators,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.water_damage),
            label: AppLocalizations.of(context).tabPeritoneal,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context).tabProfile,
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
        return HealthStatusTab();
      case 2:
        return AutomaticPeritonealDialysisTab();
      case 3:
        return AccountTab();
      default:
        throw ArgumentError("Tab with index $_currentIndex doesn't exist");
    }
  }

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }
}
