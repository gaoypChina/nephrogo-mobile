import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/daily_norms_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report_response.dart';

class NutritionDailySummaryScreenArguments {
  final Date date;
  final Nutrient nutrient;

  NutritionDailySummaryScreenArguments(this.date, {this.nutrient});
}

class NutritionDailySummaryScreen extends StatelessWidget {
  final _apiService = ApiService();

  final Date date;
  final Nutrient nutrient;

  NutritionDailySummaryScreen(
    this.date, {
    Key key,
    @required this.nutrient,
  })  : assert(date != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(appLocalizations)),
        actions: [
          TextButton(
            onPressed: () => _openGeneralRecommendations(context),
            child: Text(
              appLocalizations.tips.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProduct(context),
        label: Text(appLocalizations.createMeals.toUpperCase()),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: DailyPager(
        earliestDate: Date(2021, 1, 1),
        initialDate: date,
        bodyBuilder: (context, header, from, to) {
          return AppStreamBuilder<DailyIntakesReportResponse>(
            stream: _apiService.getDailyIntakesReportStream(from),
            builder: (context, data) {
              Widget child;
              if (nutrient != null) {
                child = _DailyNutritionNutrientList(
                  data.dailyIntakesReport,
                  nutrient,
                  header: header,
                );
              } else {
                child = _NutritionDailySummaryList(
                  data.dailyIntakesReport,
                  header: header,
                );
              }

              return Visibility(
                visible: data.dailyIntakesReport.intakes.isNotEmpty,
                replacement: Column(children: [
                  BasicSection.single(
                    header,
                    innerPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  Expanded(
                    child: EmptyStateContainer(
                      text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                    ),
                  ),
                ]),
                child: child,
              );
            },
          );
        },
      ),
    );
  }

  String _getTitle(AppLocalizations appLocalizations) {
    if (nutrient == null) {
      return appLocalizations.dailyNutritionSummary;
    }

    return nutrient.consumptionName(appLocalizations);
  }

  Future _openGeneralRecommendations(BuildContext context) {
    return Navigator.pushNamed(context, Routes.routeFAQ);
  }

  Future _createProduct(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchScreenArguments(ProductSearchType.choose),
    );
  }
}

class _NutritionDailySummaryList extends StatelessWidget {
  final DailyIntakesReport dailyIntakesReport;
  final Widget header;

  const _NutritionDailySummaryList(
    this.dailyIntakesReport, {
    Key key,
    @required this.header,
  })  : assert(header != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final norms = dailyIntakesReport.dailyNutrientNormsAndTotals;
    final intakes = dailyIntakesReport.intakes
        .sortedBy((i) => i.consumedAt, reverse: true)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: intakes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection(
            innerPadding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              header,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DailyNormsBarChart(
                      dailyIntakeReport: dailyIntakesReport,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return IntakeWithNormsSection(intakes[index - 1], norms);
      },
    );
  }
}

class _DailyNutritionNutrientList extends StatelessWidget {
  final Widget header;
  final DailyIntakesReport dailyIntakesReport;
  final Nutrient nutrient;

  const _DailyNutritionNutrientList(
    this.dailyIntakesReport,
    this.nutrient, {
    Key key,
    @required this.header,
  })  : assert(header != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final intakes = dailyIntakesReport.intakes
        .sortedBy((i) => i.consumedAt, reverse: true)
        .toList();
    final norms = dailyIntakesReport.dailyNutrientNormsAndTotals;

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 80),
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: intakes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection.single(
            header,
            innerPadding: const EdgeInsets.symmetric(vertical: 8),
          );
        }

        return NutrientIntakeTile(intakes[index - 1], nutrient, norms);
      },
    );
  }
}
