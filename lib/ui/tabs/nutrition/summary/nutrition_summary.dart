import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:nephrogo_api_client/model/nutrition_summary_statistics.dart';

import 'nutrition_nutrient_summary_list.dart';
import 'nutrition_summary_components.dart';
import 'nutrition_summary_list.dart';

enum NutritionSummaryScreenType { weekly, monthly }

class NutritionSummaryScreenArguments {
  final Nutrient nutrient;
  final NutritionSummaryScreenType screenType;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  NutritionSummaryScreenArguments({
    @required this.screenType,
    @required this.nutritionSummaryStatistics,
    this.nutrient,
  })  : assert(screenType != null),
        assert(nutritionSummaryStatistics != null);
}

class NutritionSummaryScreen extends StatefulWidget {
  final Nutrient nutrient;
  final NutritionSummaryScreenType screenType;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  const NutritionSummaryScreen({
    Key key,
    @required this.screenType,
    @required this.nutrient,
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
          title: Text(_tabTitle),
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
            _NutritionWeeklySummaryTabBody(
              nutrient: widget.nutrient,
              nutritionSummaryStatistics: widget.nutritionSummaryStatistics,
            ),
            _NutritionMonthlySummaryTabBody(
              nutrient: widget.nutrient,
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

  String get _tabTitle {
    if (widget.nutrient == null) {
      return appLocalizations.nutritionSummary;
    }

    return widget.nutrient.consumptionName(appLocalizations);
  }
}

class _NutritionMonthlySummaryTabBody extends StatelessWidget {
  final _apiService = ApiService();

  final Nutrient nutrient;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  _NutritionMonthlySummaryTabBody({
    Key key,
    @required this.nutritionSummaryStatistics,
    @required this.nutrient,
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
              final reports = data.dailyIntakesLightReports.toList();

              if (reports.isEmpty) {
                return NutritionListWithHeaderEmpty(header: header);
              }

              return _buildListComponent(header, reports);
            },
          );
        },
      ),
    );
  }

  Widget _buildListComponent(
    Widget header,
    List<DailyIntakesLightReport> reports,
  ) {
    if (nutrient != null) {
      return NutritionNutrientMonthlyReportsList(
        header: header,
        reports: reports,
        nutrient: nutrient,
      );
    }

    return NutritionMonthlyReportsList(
      header: header,
      reports: reports,
    );
  }
}

class _NutritionWeeklySummaryTabBody extends StatelessWidget {
  final _apiService = ApiService();

  final Nutrient nutrient;
  final NutritionSummaryStatistics nutritionSummaryStatistics;

  _NutritionWeeklySummaryTabBody({
    Key key,
    @required this.nutrient,
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
              final reports = data.dailyIntakesLightReports.toList();

              if (reports.isEmpty) {
                return NutritionListWithHeaderEmpty(header: header);
              }

              return _buildListComponent(header, reports, to);
            },
          );
        },
      ),
    );
  }

  Widget _buildListComponent(
    Widget header,
    List<DailyIntakesLightReport> reports,
    Date dateTo,
  ) {
    if (nutrient != null) {
      return NutritionNutrientWeeklyReportsList(
        header: header,
        reports: reports,
        dateTo: dateTo,
        nutrient: nutrient,
      );
    }

    return NutritionWeeklyReportsList(header: header, reports: reports);
  }
}
