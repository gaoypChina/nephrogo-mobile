import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/nutrient_bar_chart.dart';
import 'package:nephrolog/ui/charts/today_nutrients_consumption_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/tabs/nutrition/weekly_nutrients_screen.dart';
import 'package:nephrolog_api_client/model/daily_intake.dart';
import 'package:nephrolog_api_client/model/daily_intakes_screen.dart';
import 'package:nephrolog_api_client/model/intake.dart';

import 'creation/product_search.dart';

class NutritionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showProductSearch(context, ProductSearchType.choose),
        label: Text(AppLocalizations.of(context).createMeal.toUpperCase()),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NutritionTabBody(),
    );
  }
}

class NutritionTabBody extends StatelessWidget {
  final now = DateTime.now();
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final from = now.startOfDay().subtract(Duration(days: 6));
    final to = now.endOfDay();

    return AppFutureBuilder<DailyIntakesScreen>(
      future: apiService.getUserIntakes(from, to),
      builder: (BuildContext context, DailyIntakesScreen data) {
        final dailyIntakes = data.dailyIntakes.toList();
        final intakes = dailyIntakes
            .expand((e) => e.intakes)
            .sortedBy((e) => e.dateTime, reverse: true)
            .toList();
        final latestIntakes = intakes.take(3).toList();
        final latestDailyIntake = dailyIntakes.maxBy((e) => e.date);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 64),
            child: Column(
              children: [
                DailyNormsSection(dailyIntake: latestDailyIntake),
                DailyIntakesCard(
                  title: AppLocalizations.of(context).lastMealsSectionTitle,
                  intakes: latestIntakes,
                ),
                ..._buildIndicatorChartSections(context, dailyIntakes),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildIndicatorChartSections(
    BuildContext context,
    List<DailyIntake> dailyIntakes,
  ) {
    return Nutrient.values
        .map((t) => buildIndicatorChartSection(context, dailyIntakes, t))
        .toList();
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
    List<DailyIntake> dailyIntakes,
    Nutrient nutrient,
  ) {
    final localizations = AppLocalizations.of(context);
    final newestDailyIntake = dailyIntakes.maxBy((e) => e.date);

    final dailyNormFormatted =
        newestDailyIntake.userIntakeNorms.getNutrientAmountFormatted(nutrient);
    final todayConsumption =
        newestDailyIntake.getNutrientTotalAmountFormatted(nutrient);

    final showGraph = dailyIntakes.expand((e) => e.intakes).isNotEmpty;

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
          NutrientBarChart(
            dailyIntakes: dailyIntakes,
            nutrient: nutrient,
          ),
      ],
      leading: OutlineButton(
        child: Text(localizations.more.toUpperCase()),
        onPressed: () => openIntakesScreen(context, nutrient),
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  final DailyIntake dailyIntake;

  const DailyNormsSection({
    Key key,
    this.dailyIntake,
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
            TodayNutrientsConsumptionBarChart(
              dailyIntake: dailyIntake,
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
    final intakeTiles =
        intakes.map((intake) => IntakeTile(intake: intake)).toList();

    return LargeSection(
      title: title,
      subTitle: subTitle,
      leading: leading,
      children: intakeTiles,
    );
  }
}

class IntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat(
    "E, d MMM HH:mm",
  );

  final Intake intake;

  const IntakeTile({Key key, this.intake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = intake.product;

    return ListTile(
      key: ObjectKey(intake),
      title: Text(product.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        dateFormat.format(intake.dateTime).capitalizeFirst(),
      ),
      leading: ProductKindIcon(productKind: product.kind),
      trailing: Text(intake.getAmountFormatted()),
    );
  }
}
