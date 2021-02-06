import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/intakes_number_weekly_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/weekly_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';
import 'package:nephrogo_api_client/model/nutrient_weekly_screen_response.dart';
import 'package:tuple/tuple.dart';

import 'components.dart';
import 'nutrition_tab.dart';

class WeeklyIntakesScreen extends StatefulWidget {
  const WeeklyIntakesScreen({Key key}) : super(key: key);

  @override
  _WeeklyIntakesScreenState createState() => _WeeklyIntakesScreenState();
}

class _WeeklyIntakesScreenState extends State<WeeklyIntakesScreen> {
  final _apiService = ApiService();

  ValueNotifier<bool> _valueChangeNotifier;

  DateTime _earliestDate;

  @override
  void initState() {
    super.initState();
    _valueChangeNotifier = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.myMeals)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProduct(context),
        label: Text(appLocalizations.createMeal.toUpperCase()),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: WeeklyPager<bool>(
        valueChangeNotifier: _valueChangeNotifier,
        earliestDate: () => _earliestDate,
        bodyBuilder: (from, to, nutrient) {
          return AppStreamBuilder<NutrientWeeklyScreenResponse>(
            stream: _apiService.getWeeklyDailyIntakesReportStream(from, to),
            builder: (context, data) {
              _earliestDate = data.earliestReportDate;

              return _IntakesListComponent(
                dailyIntakesReports: data.dailyIntakesReports.toList(),
                maximumDate: to,
              );
            },
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

  @override
  void dispose() {
    _valueChangeNotifier.dispose();
    super.dispose();
  }
}

class _IntakesListComponent extends StatelessWidget {
  final List<DailyIntakesReport> dailyIntakesReports;
  final DateTime maximumDate;

  const _IntakesListComponent({
    Key key,
    @required this.dailyIntakesReports,
    @required this.maximumDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intakesWithNorms = dailyIntakesReports
        .expand(
          (r) => r.intakes.map(
            (i) => Tuple2(i, r.dailyNutrientNormsAndTotals),
          ),
        )
        .sortedBy((e) => e.item1.consumedAt, reverse: true)
        .toList();

    return Visibility(
      visible: intakesWithNorms.isNotEmpty,
      replacement: EmptyStateContainer(
        text: AppLocalizations.of(context).weeklyNutrientsEmpty,
      ),
      child: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 64),
          itemCount: intakesWithNorms.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return BasicSection(
                children: [
                  IntakesNumberWeeklyBarChart(
                    dailyIntakeReports: dailyIntakesReports,
                    maximumDate: maximumDate,
                  ),
                ],
              );
            }

            final intakeWithNorms = intakesWithNorms[index - 1];
            final intake = intakeWithNorms.item1;
            final dailyNutrientNormsAndTotals = intakeWithNorms.item2;

            return BasicSection(
              key: ObjectKey(intake),
              header: IntakeTile(intake, dailyNutrientNormsAndTotals),
              showDividers: true,
              children: [
                for (final nutrient in Nutrient.values)
                  IntakeNutrientTile(
                    intake,
                    nutrient,
                    dailyNutrientNormsAndTotals,
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
