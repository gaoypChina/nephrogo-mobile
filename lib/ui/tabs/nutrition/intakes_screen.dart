import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/indicator_bar_chart.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';

import 'nutrition_tab.dart';

class IntakesScreenArguments {
  final IndicatorType intakesScreenType;

  IntakesScreenArguments(this.intakesScreenType);
}

class IntakesScreen extends StatefulWidget {
  final IndicatorType type;

  const IntakesScreen({Key key, @required this.type}) : super(key: key);

  @override
  _IntakesScreenState createState() => _IntakesScreenState();
}

class _IntakesScreenState extends State<IntakesScreen> {
  final dateFormatter = DateFormat.MMMMd();

  // It's hacky, but let's load pages nearby
  final controller = PageController(viewportFraction: 0.9999999);
  DateTime today = DateTime.now();

  DateTime initialWeekStart;
  DateTime initialWeekEnd;

  DateTime weekStart;
  DateTime weekEnd;

  @override
  void initState() {
    super.initState();

    initialWeekStart =
        today.startOfDay().subtract(Duration(days: today.weekday - 1));
    initialWeekEnd = today
        .endOfDay()
        .add(Duration(days: DateTime.daysPerWeek - today.weekday));

    weekStart = initialWeekStart;
    weekEnd = initialWeekEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getAppTitle())),
      body: PageView.builder(
        controller: controller,
        onPageChanged: changeWeek,
        reverse: true,
        itemBuilder: (context, index) {
          return _WeeklyIntakesComponent(
            type: widget.type,
            weekStart: calculateWeekStart(index),
            weekEnd: calculateWeekEnd(index),
          );
        },
      ),
    );
  }

  String _getAppTitle() {
    return "${dateFormatter.format(weekStart)} - ${dateFormatter.format(weekEnd)}"
        .capitalizeFirst();
  }

  DateTime calculateWeekStart(int n) {
    final changeDuration = Duration(days: 7 * n);

    return initialWeekStart.subtract(changeDuration);
  }

  DateTime calculateWeekEnd(int n) {
    final changeDuration = Duration(days: 7 * n);

    return initialWeekEnd.subtract(changeDuration);
  }

  changeWeek(int index) {
    setState(() {
      weekStart = calculateWeekStart(index);
      weekEnd = calculateWeekEnd(index);
    });
  }
}

class _WeeklyIntakesComponent extends StatelessWidget {
  final apiService = const ApiService();

  final IndicatorType type;

  final DateTime weekStart;
  final DateTime weekEnd;

  const _WeeklyIntakesComponent({
    Key key,
    @required this.type,
    @required this.weekStart,
    @required this.weekEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DailyIntakesResponse>(
      future: apiService.getUserIntakesResponse(weekStart, weekEnd),
      builder:
          (BuildContext context, AsyncSnapshot<DailyIntakesResponse> snapshot) {
        if (snapshot.hasData) {
          final dailyIntakes = snapshot.data.dailyIntakes;

          return Column(
            children: [
              BasicSection(children: [
                IndicatorBarChart(
                  dailyIntakes: dailyIntakes,
                  type: type,
                ),
              ]),
              // IntakesScreenTab(dailyIntakes: dailyIntakes, type: type),
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error));
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}

class IntakesScreenTab extends StatelessWidget {
  static final _dateFormat = DateFormat("E, d MMM");

  final IndicatorType type;
  final List<DailyIntake> dailyIntakes;

  const IntakesScreenTab({
    Key key,
    @required this.type,
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
