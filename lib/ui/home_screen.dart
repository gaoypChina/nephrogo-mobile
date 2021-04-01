import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/utils/app_store_utils.dart';

import 'general/app_bar_logo.dart';
import 'general_recommendations_screen.dart';
import 'tabs/account/account_tab.dart';
import 'tabs/health_status/health_status_tab.dart';
import 'tabs/nutrition/nutrition_tab.dart';
import 'tabs/peritoneal_dialysis/peritoneal_dialysis_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _appReview = AppReview();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _appReview.requestReviewConditionally(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getTitle(),
        centerTitle: true,
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: getTabBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: appLocalizations.tabNutrition,
            icon: const Icon(Icons.restaurant_outlined),
            activeIcon: const Icon(Icons.restaurant),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.tabGeneralRecommendations,
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.tabHealthIndicators,
            icon: const Icon(Icons.assessment_outlined),
            activeIcon: const Icon(Icons.assessment),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.tabPeritoneal,
            icon: const Icon(Icons.water_damage_outlined),
            activeIcon: const Icon(Icons.water_damage),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.tabProfile,
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _getTitle() {
    switch (_currentIndex) {
      case 0:
        return const AppBarLogo();
      case 1:
        return Text(appLocalizations.generalRecommendations);
      case 2:
        return Text(appLocalizations.healthStatusIndicators);
      case 3:
        return Text(appLocalizations.peritonealDialysisPlural);
      case 4:
        return Text(appLocalizations.myProfile);
      default:
        throw ArgumentError("Tab with index $_currentIndex doesn't exist");
    }
  }

  Widget getTabBody() {
    switch (_currentIndex) {
      case 0:
        return NutritionTab();
      case 1:
        return GeneralRecommendationsTab();
      case 2:
        return HealthStatusTab();
      case 3:
        return PeritonealDialysisTab();
      case 4:
        return AccountTab();
      default:
        throw ArgumentError("Tab with index $_currentIndex doesn't exist");
    }
  }

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }
}
