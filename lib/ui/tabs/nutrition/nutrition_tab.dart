import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/daily_norms_bar_chart.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

import 'nutrition_calendar.dart';
import 'nutrition_components.dart';
import 'summary/nutrition_summary.dart';

class NutritionTab extends StatelessWidget {
  final now = DateTime.now();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IntakeCreationFloatingActionButton(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return AppStreamBuilder<NutritionScreenV2Response>(
      stream: apiService.getNutritionScreenStream(),
      builder: (context, data) {
        final latestIntakes = data.latestIntakes.toList();

        if (latestIntakes.isEmpty) {
          return EmptyStateContainer(text: appLocalizations.nutritionEmpty);
        }

        final lastWeekLightNutritionReports =
            data.lastWeekLightNutritionReports.toList();
        final currentMonthNutritionReports =
            data.currentMonthNutritionReports.toList();

        final todayIntakesReport = data.todayLightNutritionReport;
        final nutritionSummaryStatistics = data.nutritionSummaryStatistics;
        final dailyNutrientNormsWithTotals =
            todayIntakesReport.nutrientNormsAndTotals;

        final nutrients =
            dailyNutrientNormsWithTotals.getSortedNutrientsByExistence();

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DailyNormsSection(
                nutritionLightReport: todayIntakesReport,
              ),
            ),
            SliverToBoxAdapter(
              child: DailyIntakesCard(
                title: appLocalizations.lastMealsSectionTitle,
                intakes: latestIntakes,
                dailyNutrientNormsWithTotals: dailyNutrientNormsWithTotals,
                leading: OutlinedButton(
                  onPressed: () => _openNutritionDailySummary(
                    context,
                    nutritionSummaryStatistics,
                  ),
                  child: Text(appLocalizations.more.toUpperCase()),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: MonthlyNutritionSummarySection(
                currentMonthNutritionReports,
                nutritionSummaryStatistics,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final nutrient = nutrients[index];

                  return NutrientChartSection(
                    reports: lastWeekLightNutritionReports,
                    nutritionSummaryStatistics: nutritionSummaryStatistics,
                    nutrient: nutrient,
                  );
                },
                childCount: nutrients.length,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 64)),
          ],
        );
      },
    );
  }

  Future<void> _openNutritionDailySummary(
    BuildContext context,
    NutritionSummaryStatistics nutritionSummaryStatistics,
  ) {
    return Navigator.pushNamed(
      context,
      Routes.routeNutritionSummary,
      arguments: NutritionSummaryScreenArguments(
        screenType: NutritionSummaryScreenType.daily,
        nutritionSummaryStatistics: nutritionSummaryStatistics,
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  final DailyIntakesLightReport nutritionLightReport;

  const DailyNormsSection({
    Key? key,
    required this.nutritionLightReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return LargeSection(
      title: Text(appLocalizations.dailyNormsSectionTitle),
      subtitle: Text(appLocalizations.dailyNormsSectionSubtitle),
      children: [
        DailyNormsBarChart(dailyIntakeReport: nutritionLightReport),
      ],
    );
  }
}

class DailyIntakesCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final List<Intake> intakes;
  final DailyNutrientNormsWithTotals dailyNutrientNormsWithTotals;

  const DailyIntakesCard({
    Key? key,
    required this.title,
    required this.intakes,
    required this.dailyNutrientNormsWithTotals,
    this.subTitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: Text(title),
      subtitle: subTitle != null ? Text(subTitle!) : null,
      trailing: leading,
      showDividers: true,
      children: [
        for (final intake in intakes)
          IntakeExpandableTile(
            intake,
            dailyNutrientNormsWithTotals,
          ),
      ],
    );
  }
}

class MonthlyNutritionSummarySection extends StatelessWidget {
  final List<DailyIntakesLightReport> reports;
  final NutritionSummaryStatistics nutritionSummaryStatistics;
  final _monthFormat = DateFormat('MMMM ');

  MonthlyNutritionSummarySection(
    this.reports,
    this.nutritionSummaryStatistics, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final monthFormatted = _monthFormat.format(DateTime.now());

    final title = '$monthFormatted${appLocalizations.summary.toLowerCase()}'
        .capitalizeFirst();
    return LargeSection(
      title: Text(title),
      subtitle: const NutrientCalendarExplanation(),
      trailing: OutlinedButton(
        onPressed: () => _openNutritionSummary(
          context,
          nutritionSummaryStatistics,
        ),
        child: Text(appLocalizations.more.toUpperCase()),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: NutritionCalendar(
            reports,
            onDaySelected: (_) => _openNutritionSummary(
              context,
              nutritionSummaryStatistics,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openNutritionSummary(
    BuildContext context,
    NutritionSummaryStatistics nutritionSummaryStatistics,
  ) {
    return Navigator.pushNamed(
      context,
      Routes.routeNutritionSummary,
      arguments: NutritionSummaryScreenArguments(
        screenType: NutritionSummaryScreenType.monthly,
        nutritionSummaryStatistics: nutritionSummaryStatistics,
      ),
    );
  }
}
