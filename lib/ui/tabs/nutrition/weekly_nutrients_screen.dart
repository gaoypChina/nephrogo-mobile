import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/nutrient_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/weekly_pager.dart';

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
  static final dateFormatter = DateFormat.MMMMd();

  final _apiService = const ApiService();

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
        onPressed: _showIndicatorSelectionPopupMenu,
        label: Text("MEDŽIAGA"),
        icon: Icon(Icons.swap_horizontal_circle),
      ),
      body: WeeklyPager<Nutrient>(
        valueChangeNotifier: nutrientChangeNotifier,
        bodyBuilder: (from, to, nutrient) {
          return AppFutureBuilder<UserIntakesResponse>(
            future: _apiService.getUserIntakes(from, to),
            builder: (context, data) {
              return _WeeklyNutrientsComponent(
                nutrient: nutrient,
                weekStart: from,
                weekEnd: to,
                userIntakesResponse: data,
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

  Future _showIndicatorSelectionPopupMenu() async {
    final options = Nutrient.values.map((t) {
      return SimpleDialogOption(
        child: Text(t.name),
        onPressed: () => Navigator.pop(context, t),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      );
    }).toList();

    // show the dialog
    final selectedType = await showDialog<Nutrient>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pasirinkite maisto medžiagą'),
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
  final UserIntakesResponse userIntakesResponse;
  final Nutrient nutrient;

  final DateTime weekStart;
  final DateTime weekEnd;

  const _WeeklyNutrientsComponent({
    Key key,
    @required this.nutrient,
    @required this.weekStart,
    @required this.weekEnd,
    @required this.userIntakesResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyIntakes = userIntakesResponse.dailyIntakes;

    final dailyIntakesSections = userIntakesResponse.dailyIntakes
        .map((di) => DailyIntakeSection(
              nutrient: nutrient,
              dailyIntake: di,
            ))
        .toList();

    return ListView(
      padding: EdgeInsets.only(bottom: 64),
      children: [
        BasicSection(
          children: [
            NutrientBarChart(
              dailyIntakes: dailyIntakes,
              nutrient: nutrient,
            ),
          ],
        ),
        ...dailyIntakesSections,
      ],
    );
  }
}

class DailyIntakeSection extends StatelessWidget {
  static final _dateFormat = DateFormat("EEEE, d");

  final Nutrient nutrient;
  final DailyIntake dailyIntake;

  DailyIntakeSection({
    Key key,
    @required this.nutrient,
    @required this.dailyIntake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = dailyIntake.getNutrientConsumptionRatio(nutrient);
    final dailyNormFormatted =
        dailyIntake.userIntakeNorms.getNutrientAmountFormatted(nutrient);
    final consumptionFormatted =
        dailyIntake.getNutrientTotalAmountFormatted(nutrient);

    return LargeSection(
      title: _dateFormat.format(dailyIntake.date).capitalizeFirst() + " d.",
      leading: _getVisualIndicator(ratio),
      subTitle: "$consumptionFormatted iš $dailyNormFormatted",
      children: dailyIntake.intakes
          .map(
            (intake) => IndicatorIntakeTile(
              intake: intake,
              nutrient: nutrient,
            ),
          )
          .toList(),
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

    final dateFormatted = dateFormat.format(intake.dateTime).capitalizeFirst();

    return ListTile(
      title: Text(product.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        "${intake.getAmountFormatted()} | $dateFormatted",
      ),
      leading: ProductKindIcon(productKind: product.kind),
      trailing: Text(intake.getNutrientAmountFormatted(nutrient)),
    );
  }
}
