import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/intake.dart';
import 'package:nephrolog/extensions/StringExtension.dart';

import 'tabs/nutrition_tab.dart';

class IntakesScreenArguments {
  final IntakesScreenType intakesScreenType;

  IntakesScreenArguments(this.intakesScreenType);
}

class _IntakesScreenTabData {
  final String name;
  final IntakesScreenType screenType;

  const _IntakesScreenTabData(this.name, this.screenType);

  IntakesScreenTab body(List<DailyIntake> dailyIntakes) => IntakesScreenTab(
        intakesScreenType: screenType,
        dailyIntakes: dailyIntakes,
      );
}

class IntakesScreen extends StatelessWidget {
  final IntakesScreenType intakesScreenType;

  static final dailyIntakes = DailyIntake.generateDummies();

  static final _tabs = [
    _IntakesScreenTabData("KALIS", IntakesScreenType.potassium),
    _IntakesScreenTabData("BALTYMAI", IntakesScreenType.proteins),
    _IntakesScreenTabData("NATRIS", IntakesScreenType.sodium),
    _IntakesScreenTabData("FORFORAS", IntakesScreenType.phosphorus),
    _IntakesScreenTabData("ENERGIJA", IntakesScreenType.energy),
    _IntakesScreenTabData("SKYSČIAI", IntakesScreenType.liquids),
  ];

  const IntakesScreen({Key key, @required this.intakesScreenType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: _tabs.indexWhere((t) => t.screenType == intakesScreenType),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nephrolog"),
          centerTitle: true,
          bottom: TabBar(
            tabs: _tabs.map((t) => Tab(text: t.name)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: _tabs.map((t) => t.body(dailyIntakes)).toList(),
        ),
      ),
    );
  }
}

class IntakesScreenTab extends StatelessWidget {
  static final _dateFormat = DateFormat("E, d MMM");

  final IntakesScreenType intakesScreenType;
  final List<DailyIntake> dailyIntakes;

  const IntakesScreenTab({
    Key key,
    @required this.intakesScreenType,
    @required this.dailyIntakes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: dailyIntakes.length,
        itemBuilder: (context, index) {
          final dailyIntake = dailyIntakes[index];

          return DailyIntakesCard(
            title: _dateFormat.format(dailyIntake.date).capitalizeFirst(),
            leading: Text("4.8 g"),
            subTitle: "5 g dienos norma neviršyta",
            intakes: dailyIntake.intakes,
          );
        },
      ),
    );
  }
}
