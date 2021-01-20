import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/daily_norms_bar_chart.dart';
import 'package:nephrogo/ui/charts/nutrient_weekly_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';
import 'package:nephrogo_api_client/model/intake.dart';
import 'package:nephrogo_api_client/model/nutrient_screen_response.dart';

import 'intake_create.dart';
import 'product_search.dart';
import 'weekly_nutrients_screen.dart';

class NutritionTab extends StatelessWidget {
  final now = DateTime.now();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createProduct(context),
        label: Text(appLocalizations.createMeal.toUpperCase()),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildBody(context),
    );
  }

  Future _createProduct(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.ROUTE_PRODUCT_SEARCH,
      arguments: ProductSearchType.choose,
    );
  }

  Widget _buildBody(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return AppStreamBuilder<NutrientScreenResponse>(
      stream: apiService.getNutritionScreenStream(),
      builder: (context, data) {
        final latestIntakes = data.latestIntakes.toList();
        final dailyIntakesReports = data.dailyIntakesReports.toList();
        final todayIntakesReport = data.todayIntakesReport;

        return Visibility(
          visible: latestIntakes.isNotEmpty,
          replacement: EmptyStateContainer(
            text: appLocalizations.nutritionEmpty,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Column(
                children: [
                  // if (intakes.isEmpty) _buildNoMealsBanner(),
                  DailyNormsSection(dailyIntakeReport: todayIntakesReport),
                  // if (intakes.isNotEmpty)
                  DailyIntakesCard(
                    title: appLocalizations.lastMealsSectionTitle,
                    intakes: latestIntakes,
                  ),
                  for (final nutrient in Nutrient.values)
                    buildIndicatorChartSection(
                      context,
                      todayIntakesReport,
                      dailyIntakesReports,
                      nutrient,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  openIntakesScreen(BuildContext context, Nutrient indicator) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_DAILY_WEEKLY_NUTRIENTS_SCREEN,
      arguments: WeeklyNutrientsScreenArguments(indicator),
    );
  }

  LargeSection buildIndicatorChartSection(
    BuildContext context,
    DailyIntakesReport todayIntakesReport,
    List<DailyIntakesReport> dailyIntakesReports,
    Nutrient nutrient,
  ) {
    final localizations = AppLocalizations.of(context);

    final dailyNormFormatted =
        todayIntakesReport.getNutrientNormFormatted(nutrient);
    final todayConsumption =
        todayIntakesReport.getNutrientTotalAmountFormatted(nutrient);

    final showGraph = dailyIntakesReports.expand((e) => e.intakes).isNotEmpty;

    String subtitle;
    if (dailyNormFormatted != null) {
      subtitle = localizations.todayConsumptionWithNorm(
        todayConsumption,
        dailyNormFormatted,
      );
    } else {
      subtitle = localizations.todayConsumptionWithoutNorm(
        todayConsumption,
      );
    }

    return LargeSection(
      title: nutrient.name(localizations),
      subTitle: subtitle,
      children: [
        if (showGraph)
          NutrientWeeklyBarChart(
            dailyIntakeReports: dailyIntakesReports,
            nutrient: nutrient,
            maximumDate: todayIntakesReport.date,
            fitInsideVertically: false,
          )
      ],
      leading: OutlineButton(
        child: Text(localizations.more.toUpperCase()),
        onPressed: () => openIntakesScreen(context, nutrient),
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  final DailyIntakesReport dailyIntakeReport;

  const DailyNormsSection({
    Key key,
    this.dailyIntakeReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: AppLocalizations.of(context).dailyNormsSectionTitle,
      subTitle: AppLocalizations.of(context).dailyNormsSectionSubtitle,
      leading: IconButton(
        icon: Icon(
          Icons.help_outline,
        ),
        onPressed: () => showInformationScreen(context),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DailyNormsBarChart(
              dailyIntakeReport: dailyIntakeReport,
            ),
          ],
        ),
      ],
    );
  }

  Future showInformationScreen(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.ROUTE_FAQ,
    );
  }
}

class DailyIntakesCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget leading;
  final List<Intake> intakes;

  const DailyIntakesCard({
    Key key,
    this.title,
    this.subTitle,
    this.leading,
    @required this.intakes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: title,
      subTitle: subTitle,
      leading: leading,
      children: [
        for (final intake in intakes) IntakeTile(intake: intake),
      ],
    );
  }
}

class IntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat("E, d MMM HH:mm");

  final Intake intake;

  const IntakeTile({Key key, @required this.intake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      key: ObjectKey(intake),
      title: Text(intake.product.name),
      subtitle: Text(
        dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst(),
      ),
      leading: ProductKindIcon(productKind: intake.product.productKind),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(intake.getAmountFormatted()),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.ROUTE_INTAKE_CREATE,
        arguments: IntakeCreateScreenArguments(intake: intake),
      ),
    );
  }
}
