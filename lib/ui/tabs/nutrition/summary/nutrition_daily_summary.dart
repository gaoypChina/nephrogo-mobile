import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/daily_meal_type_consumption_column_series.dart';
import 'package:nephrogo/ui/charts/daily_norms_bar_chart.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class NutritionDailySummaryScreenArguments {
  final Date date;
  final Nutrient? nutrient;

  NutritionDailySummaryScreenArguments(this.date, {this.nutrient});
}

class NutritionDailySummaryScreen extends StatelessWidget {
  final Date date;
  final Nutrient? nutrient;

  const NutritionDailySummaryScreen(
    this.date, {
    super.key,
    required this.nutrient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_getTitle(context.appLocalizations))),
      body: NutritionDailySummaryBody(
        date: date,
        nutrient: nutrient,
      ),
    );
  }

  String _getTitle(AppLocalizations appLocalizations) {
    return nutrient?.consumptionName(appLocalizations) ??
        appLocalizations.dailyNutritionSummary;
  }
}

class NutritionDailySummaryBody extends StatefulWidget {
  final Date date;
  final Nutrient? nutrient;

  const NutritionDailySummaryBody({
    super.key,
    required this.date,
    this.nutrient,
  });

  @override
  _NutritionDailySummaryBodyState createState() =>
      _NutritionDailySummaryBodyState();
}

class _NutritionDailySummaryBodyState extends State<NutritionDailySummaryBody> {
  final _apiService = ApiService();

  late Date date;

  @override
  void initState() {
    super.initState();

    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return DailyPager(
      earliestDate: Constants.earliestDate,
      initialDate: date,
      onPageChanged: (from, to) {
        date = from;
      },
      bodyBuilder: (context, header, from, to) {
        return AppStreamBuilder<
            NullableApiResponse<DailyIntakesReportResponse>>(
          stream: () => _apiService.getDailyIntakesReportStream(from),
          builder: (context, data) {
            final report = data.data?.dailyIntakesReport;

            if (report == null || report.intakes.isEmpty) {
              return NutritionDailyListWithHeaderEmpty(
                header: header,
                date: from,
              );
            }

            if (widget.nutrient != null) {
              return _DailyNutritionNutrientList(
                report,
                widget.nutrient!,
                header: header,
              );
            }

            return _NutritionDailySummaryList(
              report,
              header: header,
            );
          },
        );
      },
    );
  }
}

class _NutritionDailySummaryList extends StatelessWidget {
  final DailyIntakesReport dailyIntakesReport;
  final Widget header;

  const _NutritionDailySummaryList(
    this.dailyIntakesReport, {
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    final norms = dailyIntakesReport.dailyNutrientNormsAndTotals;

    final groupedIntakes =
        dailyIntakesReport.getIntakesGroupedByMealType().toList();

    return ListView.builder(
      itemCount: groupedIntakes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: DailyNormsBarChart(
                  dailyIntakeReport: dailyIntakesReport.toLightReport(),
                ),
              ),
            ],
          );
        }
        final group = groupedIntakes[index - 1];

        return _NutritionDailySummaryListNutritionSection(
          mealType: group.item1,
          intakes: group.item2,
          date: dailyIntakesReport.date,
          norms: norms,
        );
      },
    );
  }
}

class _NutritionDailySummaryListNutritionSection extends StatelessWidget {
  final MealTypeEnum mealType;
  final List<Intake> intakes;
  final DailyNutrientNormsWithTotals norms;
  final Date date;

  const _NutritionDailySummaryListNutritionSection({
    required this.mealType,
    required this.intakes,
    required this.date,
    required this.norms,
  });

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: Text(mealType.localizedName(context.appLocalizations)),
      trailing: mealType != MealTypeEnum.unknown
          ? OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.routeProductSearch,
                arguments: ProductSearchScreenArguments(
                  ProductSearchType.choose,
                  mealType,
                  date: date,
                ),
              ),
              child: Text(context.appLocalizations.create.toUpperCase()),
            )
          : null,
      children: [
        for (final intake in intakes)
          IntakeWithNormsSection(
            intake,
            norms,
            margin: EdgeInsets.zero,
          )
      ],
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
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    final groupedIntakes =
        dailyIntakesReport.getIntakesGroupedByMealType().toList();

    return ListView.builder(
      itemCount: groupedIntakes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              DailyMealTypeConsumptionColumnSeries(
                report: dailyIntakesReport,
                nutrient: nutrient,
              ),
            ],
          );
        }

        final group = groupedIntakes[index - 1];

        return _DailyNutritionNutrientSection(
          nutrient: nutrient,
          mealType: group.item1,
          intakes: group.item2,
          dailyIntakesReport: dailyIntakesReport,
        );
      },
    );
  }
}

class _DailyNutritionNutrientSection extends StatelessWidget {
  final Nutrient nutrient;

  final MealTypeEnum mealType;
  final List<Intake> intakes;
  final DailyIntakesReport dailyIntakesReport;

  const _DailyNutritionNutrientSection({
    required this.nutrient,
    required this.mealType,
    required this.intakes,
    required this.dailyIntakesReport,
  });

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: Text(mealType.localizedName(context.appLocalizations)),
      subtitle: intakes.isNotEmpty ? Text(_getMealTotalText(context)) : null,
      trailing: mealType != MealTypeEnum.unknown
          ? OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.routeProductSearch,
                arguments: ProductSearchScreenArguments(
                  ProductSearchType.choose,
                  mealType,
                  date: dailyIntakesReport.date,
                ),
              ),
              child: Text(context.appLocalizations.create.toUpperCase()),
            )
          : null,
      children: [
        for (final intake in intakes)
          NutrientIntakeTile(
            intake,
            nutrient,
            dailyIntakesReport.dailyNutrientNormsAndTotals,
          )
      ],
    );
  }

  String _getMealTotalText(BuildContext context) {
    final total = intakes.sumBy((e) => e.getNutrientAmount(nutrient)).toInt();
    final formattedAmount = nutrient.formatAmount(total);

    return context.appLocalizations.consumed(formattedAmount);
  }
}
