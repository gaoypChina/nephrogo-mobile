import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/models/intake.dart';
import 'package:nephrolog/extensions/StringExtension.dart';

import 'graph.dart';

class NutritionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => print("TODO: Add dish"),
        label: Text("PRIDĖTI VALGĮ"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NutritionTabBody(),
    );
  }
}

class NutritionTabBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DailyNormsSection(),
            IntakesCard(),
            SectionCard(
              title: "Kalis",
              subTitle: "Paros norma 4 g",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
            SectionCard(
              title: "Baltymai",
              subTitle: "Paros norma 1.1 g",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
            SectionCard(
              title: "Natris",
              subTitle: "Paros norma 2.3 g",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
            SectionCard(
              title: "Fosforas",
              subTitle: "Paros norma 5 g",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
            SectionCard(
              title: "Energija",
              subTitle: "Paros norma 2800 kcal",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
            SectionCard(
              title: "Skysčiai",
              subTitle: "Paros norma 1100 ml",
              child: BarChartGraph.exampleIndicatorGraph(),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Paros normos",
      subTitle: "TODO: mini paaiškinimas",
      icon: Icons.help_outline_outlined,
      child: BarChartGraph.exampleDailyTotals(),
    );
  }
}

class SectionCard extends StatelessWidget {
  final Widget child;
  final String title;
  final String subTitle;
  final IconData icon;
  final GestureTapCallback onIconTap;

  const SectionCard({
    Key key,
    @required this.title,
    this.subTitle,
    this.icon,
    this.onIconTap,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibleIcon =
        (icon == null && onIconTap != null) ? Icons.chevron_right : icon;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (this.subTitle != null)
                          Text(
                            this.subTitle,
                            style: TextStyle(
                              color: const Color(0xff379982),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visibleIcon != null,
                    child: IconButton(
                      icon: Icon(
                        visibleIcon,
                      ),
                      onPressed: onIconTap,
                    ),
                  )
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class IntakesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intakes = Intake.dummy;

    final intakeTiles = intakes
        .map(
          (intake) => IntakeTile(intake: intake),
        )
        .toList();

    final dividedIntakeTiles = ListTile.divideTiles(
      context: context,
      tiles: intakeTiles,
    ).toList();

    return SectionCard(
      title: "Valgiai",
      child: Column(
        children: dividedIntakeTiles,
      ),
    );
  }
}

class IntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat("E, d MMM HH:mm", "lt");

  final Intake intake;

  const IntakeTile({Key key, this.intake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = intake.product;

    final icon = (product.kind == ProductKind.DRINK)
        ? Icons.local_cafe
        : Icons.local_dining;

    return Container(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(
          dateFormat.format(intake.dateTime).capitalizeFirst(),
        ),
        leading: Icon(icon),
        trailing: Text("${intake.amountG} g"),
      ),
    );
  }
}
