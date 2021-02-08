import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';

import 'nutrition_components.dart';

class MyDailyIntakesReportsScreen extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.myMeals)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProduct(context),
        label: Text(appLocalizations.createMeal.toUpperCase()),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AppStreamBuilder<DailyIntakesReportsResponse>(
        stream: _apiService.getLightDailyIntakeReportsStream(),
        builder: (context, data) {
          final dailyIntakesReportsSorted = data.dailyIntakesLightReports
              .sortedBy((e) => e.date, reverse: true)
              .toList();

          return Visibility(
            visible: dailyIntakesReportsSorted.isNotEmpty,
            replacement: EmptyStateContainer(
              text: AppLocalizations.of(context).weeklyNutrientsEmpty,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: dailyIntakesReportsSorted.length,
              itemBuilder: (context, index) {
                final dailyIntakesReport = dailyIntakesReportsSorted[index];

                return DailyIntakesReportTile(dailyIntakesReport);
              },
            ),
          );
        },
      ),
    );
  }

  Future _createProduct(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchType.choose,
    );
  }
}
