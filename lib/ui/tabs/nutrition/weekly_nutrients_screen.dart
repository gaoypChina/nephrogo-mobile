import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/nutrient_weekly_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/weekly_pager.dart';
import 'package:nephrolog_api_client/model/daily_intakes_report.dart';
import 'package:nephrolog_api_client/model/intake.dart';
import 'package:nephrolog_api_client/model/nutrient_weekly_screen_response.dart';

class WeeklyNutrientsScreenArguments {
  final Nutrient nutrient;

  WeeklyNutrientsScreenArguments(this.nutrient);
}

class WeeklyNutrientsScreen extends StatefulWidget {
  final Nutrient nutrient;

  const WeeklyNutrientsScreen({Key key, @required this.nutrient})
      : super(key: key);

  @override
  _WeeklyNutrientsScreenState createState() => _WeeklyNutrientsScreenState();
}

class _WeeklyNutrientsScreenState extends State<WeeklyNutrientsScreen> {
  final _apiService = ApiService();

  // It's hacky, but let's load pages nearby
  final pageController = PageController(viewportFraction: 0.9999999);

  ValueNotifier<Nutrient> nutrientChangeNotifier;

  final DateTime now = DateTime.now();

  DateTime initialWeekStart;
  DateTime initialWeekEnd;

  DateTime weekStart;
  DateTime weekEnd;
  Nutrient nutrient;

  @override
  void initState() {
    super.initState();

    nutrient = widget.nutrient;

    final weekStartEnd = now.startAndEndOfWeek();

    weekStart = initialWeekStart = weekStartEnd.item1;
    weekEnd = initialWeekEnd = weekStartEnd.item2;

    nutrientChangeNotifier = ValueNotifier<Nutrient>(nutrient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showIndicatorSelectionPopupMenu(context),
        label: Text("MEDŽIAGA"),
        icon: Icon(Icons.swap_horizontal_circle),
      ),
      body: WeeklyPager<Nutrient>(
        valueChangeNotifier: nutrientChangeNotifier,
        bodyBuilder: (from, to, nutrient) {
          return AppFutureBuilder<NutrientWeeklyScreenResponse>(
            future: _apiService.getWeeklyDailyIntakesReport(from, to),
            builder: (context, data) {
              return _WeeklyNutrientsComponent(
                nutrient: nutrient,
                weekStart: from,
                weekEnd: to,
                dailyIntakesReports: data.dailyIntakesReports.toList(),
              );
            },
          );
        },
      ),
    );
  }

  String _getTitle() {
    switch (nutrient) {
      case Nutrient.energy:
        return "Energijos suvartojimas";
      case Nutrient.liquids:
        return "Skysčių suvartojimas";
      case Nutrient.proteins:
        return "Baltymų suvartojimas";
      case Nutrient.sodium:
        return "Natrio suvartojimas";
      case Nutrient.potassium:
        return "Kalio suvartojimas";
      case Nutrient.phosphorus:
        return "Fosforo suvartojimas";
      default:
        throw ArgumentError.value(
            this, "type", "Unable to map indicator to name");
    }
  }

  _changeNutrient(Nutrient nutrient) {
    setState(() {
      nutrient = nutrient;
      nutrientChangeNotifier.value = nutrient;
    });
  }

  Future _showIndicatorSelectionPopupMenu(BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context);

    final options = Nutrient.values.map((t) {
      return SimpleDialogOption(
        child: Text(t.name(appLocalizations)),
        onPressed: () => Navigator.pop(context, t),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      );
    }).toList();

    final selectedType = await showDialog<Nutrient>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(appLocalizations.chooseNutrient),
          children: options,
        );
      },
    );

    if (selectedType != null) {
      _changeNutrient(selectedType);
    }
  }

  @override
  void dispose() {
    nutrientChangeNotifier.dispose();

    super.dispose();
  }
}

class _WeeklyNutrientsComponent extends StatelessWidget {
  final List<DailyIntakesReport> dailyIntakesReports;
  final Nutrient nutrient;

  final DateTime weekStart;
  final DateTime weekEnd;

  const _WeeklyNutrientsComponent({
    Key key,
    @required this.nutrient,
    @required this.weekStart,
    @required this.weekEnd,
    @required this.dailyIntakesReports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyIntakeReportsWithIntakesSorted = dailyIntakesReports
        .sortedBy((e) => e.date)
        .where((di) => di.intakes.isNotEmpty);

    final hasIntakes =
        dailyIntakesReports.expand((di) => di.intakes).isNotEmpty;

    return Visibility(
      visible: hasIntakes,
      replacement: EmptyStateContainer(
        text: AppLocalizations.of(context).weeklyNutrientsEmpty,
      ),
      child: ListView(
        padding: EdgeInsets.only(bottom: 64),
        children: [
          BasicSection(
            children: [
              NutrientWeeklyBarChart(
                dailyIntakeReports: dailyIntakesReports,
                nutrient: nutrient,
                maximumDate: weekEnd,
                fitInsideVertically: true,
              ),
            ],
          ),
          for (final dailyIntakesReport in dailyIntakeReportsWithIntakesSorted)
            DailyIntakeSection(
              nutrient: nutrient,
              dailyIntakesReport: dailyIntakesReport,
            )
        ],
      ),
    );
  }
}

class DailyIntakeSection extends StatelessWidget {
  static final _dateFormat = DateFormat("EEEE, d");

  final Nutrient nutrient;
  final DailyIntakesReport dailyIntakesReport;

  DailyIntakeSection({
    Key key,
    @required this.nutrient,
    @required this.dailyIntakesReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final consumption =
        dailyIntakesReport.getDailyNutrientConsumption(nutrient);
    final dailyNormFormatted =
        dailyIntakesReport.getNutrientNormFormatted(nutrient);
    final totalFormatted =
        dailyIntakesReport.getNutrientTotalAmountFormatted(nutrient);

    double ratio;

    if (consumption.norm != null) {
      ratio = consumption.total.toDouble() / consumption.norm;
    }

    return LargeSection(
      title:
          _dateFormat.format(dailyIntakesReport.date).capitalizeFirst() + " d.",
      leading: ratio != null ? _getVisualIndicator(ratio) : null,
      subTitle:
          getSubtitle(appLocalizations, totalFormatted, dailyNormFormatted),
      children: dailyIntakesReport.intakes
          .map(
            (intake) => IndicatorIntakeTile(
              intake: intake,
              nutrient: nutrient,
            ),
          )
          .toList(),
    );
  }

  String getSubtitle(AppLocalizations appLocalizations, String totalFormatted,
      String dailyNormFormatted) {
    if (dailyNormFormatted == null) {
      return appLocalizations.todayConsumptionWithoutNorm(
        totalFormatted,
      );
    }

    return appLocalizations.todayConsumptionWithNorm(
      totalFormatted,
      dailyNormFormatted,
    );
  }

  Widget _getVisualIndicator(double percent) {
    return Container(
      width: 70.0,
      height: 70.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: percent > 1.0 ? Colors.redAccent : Colors.teal,
          shape: BoxShape.circle),
      child: Stack(alignment: Alignment.center, children: [
        Positioned.fill(
          child: CircularProgressIndicator(
            value: percent,
            strokeWidth: 4.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        Text(
          "${(percent * 100).toInt()}%",
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}

class IndicatorIntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat(
    "MMMM d HH:mm",
  );

  final Intake intake;
  final Nutrient nutrient;

  const IndicatorIntakeTile({
    Key key,
    this.intake,
    this.nutrient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = intake.product;

    final dateFormatted =
        dateFormat.format(intake.consumedAt).capitalizeFirst();

    return ListTile(
      title: Text(product.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        "${intake.getAmountFormatted()} | $dateFormatted",
      ),
      leading: ProductKindIcon(productKind: product.productKind),
      trailing: Text(intake.getNutrientAmountFormatted(nutrient)),
    );
  }
}
