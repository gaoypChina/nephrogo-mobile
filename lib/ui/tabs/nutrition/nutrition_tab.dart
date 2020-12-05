import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/daily_indicator_consumption_bar_chart.dart';
import 'package:nephrolog/ui/charts/indicator_bar_chart.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';
import 'package:nephrolog/ui/tabs/nutrition/intakes_screen.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';

class NutritionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.ROUTE_MEAL_CREATION,
        ),
        label: Text("PRIDĖTI VALGĮ"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NutritionTabBody(),
    );
  }
}

class NutritionTabBody extends StatelessWidget {
  final now = DateTime.now();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final weekStartEnd = now.startAndEndOfWeek();

    final from = weekStartEnd.item1;
    final to = weekStartEnd.item2;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64),
        child: FutureBuilder<DailyIntakesResponse>(
          future: apiService.getUserIntakesResponse(from, to),
          builder: (BuildContext context,
              AsyncSnapshot<DailyIntakesResponse> snapshot) {
            if (snapshot.hasData) {
              final dailyIntakes = snapshot.data.dailyIntakes;
              final intakes = dailyIntakes.expand((e) => e.intakes).toList();
              intakes.sort((a, b) => b.dateTime.compareTo(a.dateTime));
              final latestIntakes = intakes.take(3).toList();

              return Column(
                children: [
                  DailyNormsSection(dailyIntake: dailyIntakes.first),
                  DailyIntakesCard(
                    title: "Valgiai",
                    intakes: latestIntakes,
                  ),
                  ..._buildIndicatorChartSections(context, dailyIntakes),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            }

            return Center(child: AppProgressIndicator());
          },
        ),
      ),
    );
  }

  List<Widget> _buildIndicatorChartSections(
    BuildContext context,
    List<DailyIntake> dailyIntakes,
  ) {
    return IndicatorType.values
        .map((t) => buildIndicatorChartSection(context, dailyIntakes, t))
        .toList();
  }

  openIntakesScreen(BuildContext context, IndicatorType indicator) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_INTAKES,
      arguments: IntakesScreenArguments(indicator),
    );
  }

  LargeSection buildIndicatorChartSection(
    BuildContext context,
    List<DailyIntake> dailyIntakes,
    IndicatorType type,
  ) {
    final dailyNormFormatted =
        dailyIntakes.first.userIntakeNorms.getFormattedIndicator(type);

    return LargeSection(
      title: type.name,
      subTitle: "Paros norma $dailyNormFormatted",
      children: [
        IndicatorBarChart(
          dailyIntakes: dailyIntakes,
          type: type,
        ),
      ],
      leading: OutlineButton(
        child: Text("DAUGIAU"),
        onPressed: () => openIntakesScreen(context, type),
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  final DailyIntake dailyIntake;

  const DailyNormsSection({
    Key key,
    this.dailyIntake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: "Paros normos",
      subTitle: "TODO: mini paaiškinimas",
      leading: IconButton(
        icon: Icon(
          Icons.help_outline_outlined,
        ),
        onPressed: () => showInformationDialog(context),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DailyTotalIndicatorBarChart(
              dailyIntake: dailyIntake,
            ),
          ],
        ),
      ],
    );
  }

  showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("TODO: Informacija"),
          content: Text("O Giedre cia jau sugalvok :)"),
          actions: [
            FlatButton(
              child: Text("GERAI"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DailyIntakesCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget leading;
  final List<Intake> intakes;

  const DailyIntakesCard({
    Key key,
    this.title,
    this.subTitle,
    this.leading,
    @required this.intakes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intakeTiles =
        intakes.map((intake) => IntakeTile(intake: intake)).toList();

    return LargeSection(
      title: title,
      subTitle: subTitle,
      leading: leading,
      children: intakeTiles,
    );
  }
}

class IntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat(
    "E, d MMM HH:mm",
  );

  final Intake intake;

  const IntakeTile({Key key, this.intake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = intake.product;

    return ListTile(
      title: Text(product.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        dateFormat.format(intake.dateTime).capitalizeFirst(),
      ),
      leading: ProductKindIcon(productKind: product.kind),
      trailing: Text("${intake.amountG} g"),
    );
  }
}
