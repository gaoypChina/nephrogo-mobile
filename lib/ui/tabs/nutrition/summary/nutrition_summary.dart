import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:nephrogo_api_client/model/nutrition_summary_statistics.dart';

import 'nutrition_monthly_summary_list.dart';

enum NutritionSummaryScreenType { weekly, monthly }

class NutritionSummaryScreenArguments {
  final NutritionSummaryScreenType screenType;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  NutritionSummaryScreenArguments(
    this.screenType,
    this.nutritionSummaryStatistics,
  );
}

class NutritionSummaryScreen extends StatefulWidget {
  final NutritionSummaryScreenType screenType;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  const NutritionSummaryScreen({
    Key key,
    @required this.screenType,
    @required this.nutritionSummaryStatistics,
  })  : assert(screenType != null),
        assert(nutritionSummaryStatistics != null),
        super(key: key);

  @override
  _NutritionSummaryScreenState createState() => _NutritionSummaryScreenState();
}

class _NutritionSummaryScreenState extends State<NutritionSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _getInitialTabIndex(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.nutritionSummary),
          bottom: TabBar(
            tabs: [
              Tab(text: appLocalizations.weekly.toUpperCase()),
              Tab(text: appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _NutritionWeeklySummaryScreenBody(
              nutritionSummaryStatistics: widget.nutritionSummaryStatistics,
            ),
            _NutritionMonthlySummaryScreenBody(
              nutritionSummaryStatistics: widget.nutritionSummaryStatistics,
            ),
          ],
        ),
      ),
    );
  }

  int _getInitialTabIndex() {
    switch (widget.screenType) {
      case NutritionSummaryScreenType.weekly:
        return 0;
      case NutritionSummaryScreenType.monthly:
        return 1;
    }

    throw ArgumentError.value(widget.screenType);
  }
}

class _NutritionMonthlySummaryScreenBody extends StatelessWidget {
  final _apiService = ApiService();

  final NutritionSummaryStatistics nutritionSummaryStatistics;

  _NutritionMonthlySummaryScreenBody({
    Key key,
    @required this.nutritionSummaryStatistics,
  })  : assert(nutritionSummaryStatistics != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: nutritionSummaryStatistics.minReportDate != null,
      replacement: EmptyStateContainer(
        text: AppLocalizations.of(context).nutritionEmpty,
      ),
      child: MonthlyPager(
        earliestDate: nutritionSummaryStatistics.minReportDate.toDate(),
        initialDate: nutritionSummaryStatistics.maxReportDate.toDate(),
        bodyBuilder: (context, header, from, to) {
          return AppStreamBuilder<DailyIntakesReportsResponse>(
            stream: _apiService.getLightDailyIntakeReportsStream(from, to),
            builder: (context, data) {
              return Visibility(
                visible: data.dailyIntakesLightReports.isNotEmpty,
                replacement: EmptyStateContainer(
                  text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                ),
                child: NutritionMonthlyReportsList(
                  header: header,
                  reports: data.dailyIntakesLightReports.toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NutritionWeeklySummaryScreenBody extends StatelessWidget {
  final _apiService = ApiService();

  final NutritionSummaryStatistics nutritionSummaryStatistics;

  _NutritionWeeklySummaryScreenBody({
    Key key,
    @required this.nutritionSummaryStatistics,
  })  : assert(nutritionSummaryStatistics != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: nutritionSummaryStatistics.minReportDate != null,
      replacement: EmptyStateContainer(
        text: AppLocalizations.of(context).nutritionEmpty,
      ),
      child: WeeklyPager(
        earliestDate: nutritionSummaryStatistics.minReportDate.toDate(),
        initialDate: nutritionSummaryStatistics.maxReportDate.toDate(),
        bodyBuilder: (context, header, from, to) {
          return AppStreamBuilder<DailyIntakesReportsResponse>(
            stream: _apiService.getLightDailyIntakeReportsStream(from, to),
            builder: (context, data) {
              return Visibility(
                visible: data.dailyIntakesLightReports.isNotEmpty,
                replacement: EmptyStateContainer(
                  text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                ),
                child: NutritionMonthlyReportsList(
                  header: header,
                  reports: data.dailyIntakesLightReports.toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
