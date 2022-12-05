import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_daily_summary.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_nutrient_summary_list.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_list.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

enum NutritionSummaryScreenType { daily, weekly, monthly }

class NutritionSummaryScreenArguments {
  final NutritionSummaryScreenType screenType;
  final Nutrient? nutrient;
  final NutritionSummaryStatistics? nutritionSummaryStatistics;

  NutritionSummaryScreenArguments({
    required this.screenType,
    required this.nutritionSummaryStatistics,
    this.nutrient,
  });
}

class NutritionSummaryScreen extends StatefulWidget {
  final NutritionSummaryScreenType screenType;
  final Nutrient? nutrient;
  final NutritionSummaryStatistics? nutritionSummaryStatistics;

  const NutritionSummaryScreen({
    super.key,
    required this.screenType,
    required this.nutrient,
    required this.nutritionSummaryStatistics,
  });

  @override
  _NutritionSummaryScreenState createState() => _NutritionSummaryScreenState();
}

class _NutritionSummaryScreenState extends State<NutritionSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _getInitialTabIndex(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_tabTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: appLocalizations.daily.toUpperCase()),
              Tab(text: appLocalizations.weekly.toUpperCase()),
              Tab(text: appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            NutritionDailySummaryBody(
              nutrient: widget.nutrient,
              date: widget.nutritionSummaryStatistics?.maxReportDate ??
                  DateTime.now().toDate(),
            ),
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
      case NutritionSummaryScreenType.daily:
        return 0;
      case NutritionSummaryScreenType.weekly:
        return 1;
      case NutritionSummaryScreenType.monthly:
        return 2;
    }
  }

  String get _tabTitle {
    if (widget.nutrient == null) {
      return appLocalizations.nutritionSummary;
    }

    return widget.nutrient!.consumptionName(appLocalizations);
  }
}

class _NutritionMonthlySummaryTabBody extends StatelessWidget {
  final _apiService = ApiService();

  final Nutrient? nutrient;
  final NutritionSummaryStatistics? nutritionSummaryStatistics;

  _NutritionMonthlySummaryTabBody({
    required this.nutritionSummaryStatistics,
    required this.nutrient,
  });

  @override
  Widget build(BuildContext context) {
    return MonthlyPager(
      earliestDate:
          nutritionSummaryStatistics?.minReportDate ?? Constants.earliestDate,
      initialDate:
          nutritionSummaryStatistics?.maxReportDate ?? DateTime.now().toDate(),
      bodyBuilder: (context, header, from, to) {
        return AppStreamBuilder<DailyIntakesReportsResponse>(
          stream: () => _apiService.getLightDailyIntakeReportsStream(from, to),
          builder: (context, data) {
            final reports = data.dailyIntakesLightReports.toList();

            if (reports.isEmpty) {
              return NutritionListWithHeaderEmpty(header: header);
            }

            if (nutrient != null) {
              return NutritionNutrientReportsList(
                header: header,
                reports: reports,
                nutrient: nutrient!,
                dateFrom: from,
                dateTo: to,
                showGraphDataLabels: false,
              );
            }

            return NutritionMonthlyReportsList(
              header: header,
              reports: reports,
            );
          },
        );
      },
    );
  }
}

class _NutritionWeeklySummaryTabBody extends StatelessWidget {
  final _apiService = ApiService();

  final Nutrient? nutrient;
  final NutritionSummaryStatistics? nutritionSummaryStatistics;

  _NutritionWeeklySummaryTabBody({
    this.nutrient,
    this.nutritionSummaryStatistics,
  });

  @override
  Widget build(BuildContext context) {
    return WeeklyPager(
      earliestDate:
          nutritionSummaryStatistics?.minReportDate ?? Constants.earliestDate,
      initialDate:
          nutritionSummaryStatistics?.maxReportDate ?? DateTime.now().toDate(),
      bodyBuilder: (context, header, from, to) {
        return AppStreamBuilder<DailyIntakesReportsResponse>(
          stream: () => _apiService.getLightDailyIntakeReportsStream(from, to),
          builder: (context, data) {
            final reports = data.dailyIntakesLightReports.toList();

            if (reports.isEmpty) {
              return NutritionListWithHeaderEmpty(header: header);
            }

            return _buildListComponent(header, reports, from, to);
          },
        );
      },
    );
  }

  Widget _buildListComponent(
    Widget header,
    List<DailyIntakesLightReport> reports,
    Date dateFrom,
    Date dateTo,
  ) {
    if (nutrient != null) {
      return NutritionNutrientReportsList(
        header: header,
        reports: reports,
        dateFrom: dateFrom,
        dateTo: dateTo,
        nutrient: nutrient!,
        showGraphDataLabels: true,
      );
    }

    return NutritionWeeklyReportsList(header: header, reports: reports);
  }
}
