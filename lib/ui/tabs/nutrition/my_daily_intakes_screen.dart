import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/daily_norms_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report_response.dart';

import 'nutrition_components.dart';

class MyDailyIntakesScreenArguments {
  final Date date;

  MyDailyIntakesScreenArguments(this.date);
}

class MyDailyIntakesScreen extends StatelessWidget {
  static final _dateFormat = DateFormat('EEEE, MMMM d');

  final _apiService = ApiService();

  final Date date;

  MyDailyIntakesScreen(this.date, {Key key})
      : assert(date != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(title: Text(_dateFormat.format(date).capitalizeFirst())),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _createProduct(context),
          label: Text(appLocalizations.createMeals.toUpperCase()),
          icon: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: AppStreamBuilder<DailyIntakesReportResponse>(
          stream: _apiService.getDailyIntakesReportStream(date),
          builder: (context, data) {
            final dailyIntakesReport = data.dailyIntakesReport;
            final norms = dailyIntakesReport.dailyNutrientNormsAndTotals;
            final intakes = dailyIntakesReport.intakes
                .sortedBy((i) => i.consumedAt, reverse: true)
                .toList();

            return Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: intakes.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return BasicSection.single(
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DailyNormsBarChart(
                          dailyIntakeReport: dailyIntakesReport,
                        ),
                      ),
                    );
                  }

                  return IntakeWithNormsTile(intakes[index - 1], norms);
                },
              ),
            );
          },
        ));
  }

  Future _createProduct(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchScreenArguments(ProductSearchType.choose),
    );
  }
}
