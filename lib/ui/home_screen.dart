import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/ui/general/app_bar_logo.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general_recommendations_screen.dart';
import 'package:nephrogo/ui/tabs/account/account_tab.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_tab.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_tab.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_tab.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_tab.dart';
import 'package:nephrogo/utils/app_store_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class HomeScreen extends StatelessWidget {
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<DialysisEnum>(
      stream: () => _appPreferences.getDialysisTypeStream(),
      builder: (context, dialysis) {
        return _HomeScreen(
          key: Key('HomeScreen-dialysis:$dialysis'),
          dialysis: dialysis,
        );
      },
    );
  }
}

class _HomeScreenTab {
  final Widget title;
  final Widget Function() builder;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _HomeScreenTab({
    required this.title,
    required this.builder,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _HomeScreen extends StatefulWidget {
  final DialysisEnum dialysis;

  const _HomeScreen({Key? key, required this.dialysis}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  final _appReview = AppReview();
  int _currentIndex = 0;

  late final List<_HomeScreenTab> _tabs = _createHomeScreenTabs();

  _HomeScreenTab get _currentTab => _tabs[_currentIndex];

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
        title: _currentTab.title,
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
        child: _currentTab.builder(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(
              label: tab.label,
              icon: Icon(tab.icon),
              activeIcon: Icon(tab.activeIcon),
            ),
        ],
      ),
    );
  }

  List<_HomeScreenTab> _createHomeScreenTabs() {
    return [
      _HomeScreenTab(
        title: const AppBarLogo(),
        builder: () => NutritionTab(),
        icon: Icons.restaurant_outlined,
        activeIcon: Icons.restaurant,
        label: appLocalizations.tabNutrition,
      ),
      _HomeScreenTab(
        title: Text(appLocalizations.healthStatusIndicators),
        builder: () => HealthStatusTab(),
        icon: Icons.assessment_outlined,
        activeIcon: Icons.assessment,
        label: appLocalizations.tabHealthIndicators,
      ),
      if (widget.dialysis == DialysisEnum.automaticPeritonealDialysis)
        _HomeScreenTab(
          title: Text(appLocalizations.peritonealDialysisTypeAutomatic),
          builder: () => AutomaticPeritonealDialysisTab(),
          icon: Icons.water_damage_outlined,
          activeIcon: Icons.water_damage,
          label: appLocalizations.tabPeritoneal,
        )
      else if (widget.dialysis == DialysisEnum.manualPeritonealDialysis)
        _HomeScreenTab(
          title: Text(appLocalizations.peritonealDialysisTypeManual),
          builder: () => ManualPeritonealDialysisTab(),
          icon: Icons.water_damage_outlined,
          activeIcon: Icons.water_damage,
          label: appLocalizations.tabPeritoneal,
        ),
      _HomeScreenTab(
        title: Text(appLocalizations.generalRecommendations),
        builder: () => GeneralRecommendationsTab(),
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore,
        label: appLocalizations.tabGeneralRecommendations,
      ),
      _HomeScreenTab(
        title: Text(appLocalizations.myProfile),
        builder: () => AccountTab(),
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: appLocalizations.tabProfile,
      ),
    ];
  }

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }
}
