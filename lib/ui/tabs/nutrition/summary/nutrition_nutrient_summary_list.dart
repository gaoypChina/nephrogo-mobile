import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/charts/nutrient_bar_chart.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class NutritionNutrientReportsList extends StatelessWidget {
  final List<DailyIntakesLightReport> reports;
  final Date dateFrom;
  final Date dateTo;
  final Widget header;
  final Nutrient nutrient;
  final bool showGraphDataLabels;

  NutritionNutrientReportsList({
    Key? key,
    required this.reports,
    required this.header,
    required this.nutrient,
    required this.dateFrom,
    required this.dateTo,
    required this.showGraphDataLabels,
  })  : assert(reports.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportsReverseSorted =
        reports.orderBy((e) => e.date, reverse: true).toList();

    return ListView.builder(
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: NutrientBarChart(
                  dailyIntakeLightReports: reportsReverseSorted,
                  nutrient: nutrient,
                  minimumDate: dateFrom.toDateTime(),
                  maximumDate: dateTo.toDateTime(),
                  showDataLabels: showGraphDataLabels,
                ),
              ),
            ],
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return BasicSection.single(
          child: NutrientDailyNutritionTile.fromLightReport(
            nutrient,
            dailyIntakesReport,
          ),
        );
      },
    );
  }
}
