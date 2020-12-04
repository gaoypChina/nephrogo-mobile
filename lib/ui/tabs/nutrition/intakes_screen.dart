import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/extensions/StringExtension.dart';

import '../../general/app_logo.dart';
import 'nutrition_tab.dart';

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
    _IntakesScreenTabData("FOSFORAS", IntakesScreenType.phosphorus),
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                stretch: true,
                title: AppLogo(),
                centerTitle: true,
                bottom: TabBar(
                  tabs: _tabs.map((t) => Tab(text: t.name)).toList(),
                  isScrollable: true,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((t) => t.body(dailyIntakes)).toList(),
          ),
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
    return ListView.builder(
      itemCount: dailyIntakes.length,
      itemBuilder: (context, index) {
        final dailyIntake = dailyIntakes[index];

        return DailyIntakesCard(
          title: _dateFormat.format(dailyIntake.date).capitalizeFirst(),
          leading:
              _getVisualIndicator(Faker().randomGenerator.decimal(scale: 1.5)),
          subTitle: "Suvartota 4.8 g\nDienos norma: 5 g",
          intakes: dailyIntake.intakes,
        );
      },
    );
  }

  Widget _getVisualIndicator(double percent) {
    return Container(
      width: 70.0,
      height: 70.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: percent > 1.0 ? Colors.redAccent : Colors.teal,
          shape: BoxShape.circle),
      child: Stack(alignment: Alignment.center, children: [
        Positioned.fill(
          child: CircularProgressIndicator(
            value: percent,
            strokeWidth: 4.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Text(
          "${(percent * 100).toInt()}%",
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}
