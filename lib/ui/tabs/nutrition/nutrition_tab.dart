import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/StringExtension.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/graph.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';
import 'package:nephrolog/ui/tabs/nutrition/intakes_screen.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';

class NutritionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.ROUTE_MEAL_CREATION,
        ),
        label: Text("PRIDĖTI VALGĮ"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NutritionTabBody(),
    );
  }
}

class NutritionTabBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<DailyIntakes>>(
        future: Future.delayed(const Duration(milliseconds: 500), () {
          return DailyIntakes.generateDummies().take(6).toList();
        }),
        builder:
            (BuildContext context, AsyncSnapshot<List<DailyIntakes>> snapshot) {
          if (snapshot.hasData) {
            final dailyIntakes = snapshot.data;
            final intakes = dailyIntakes.expand((e) => e.intakes).toList();
            intakes.sort((a, b) => b.dateTime.compareTo(a.dateTime));
            final latestIntakes = intakes.take(3).toList();

            return Column(
              children: [
                DailyNormsSection(),
                DailyIntakesCard(
                  title: "Valgiai",
                  leading: OutlineButton(
                    child: Text("DAUGIAU"),
                    onPressed: () =>
                        openIntakesScreen(context, IndicatorType.potassium),
                  ),
                  intakes: latestIntakes,
                ),
                buildIndicatorChartSection(
                  context,
                  dailyIntakes,
                  IndicatorType.potassium,
                  "Kalis",
                ),
                buildIndicatorChartSection(
                  context,
                  dailyIntakes,
                  IndicatorType.proteins,
                  "Baltymai",
                ),
                buildIndicatorChartSection(
                  context,
                  dailyIntakes,
                  IndicatorType.sodium,
                  "Natris",
                ),
                buildIndicatorChartSection(
                  context,
                  dailyIntakes,
                  IndicatorType.phosphorus,
                  "Fosforas",
                ),
                buildIndicatorChartSection(
                  context,
                  dailyIntakes,
                  IndicatorType.energy,
                  "Energija",
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          }

          return Center(child: AppProgressIndicator());
        },
      ),
    );
  }

  openIntakesScreen(BuildContext context, IndicatorType indicator) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_INTAKES,
      arguments: IntakesScreenArguments(indicator),
    );
  }

  LargeSection buildIndicatorChartSection(
    BuildContext context,
    List<DailyIntakes> dailyIntakes,
    IndicatorType type,
    String title,
  ) {
    final dailyNorm =
        dailyIntakes.first.getTotalIndicatorAmountByType(type).toDouble();
    final dailyNormFormatted = dailyIntakes.first.getFormattedDailyNorm(type);

    return LargeSection(
      title: title,
      subTitle: "Paros norma $dailyNormFormatted",
      children: [
        IndicatorBarChart(
          dailyIntakes: dailyIntakes,
          type: type,
          dailyNorm: dailyNorm,
        ),
      ],
      leading: OutlineButton(
        child: Text("DAUGIAU"),
        onPressed: () => openIntakesScreen(context, type),
      ),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: "Paros normos",
      subTitle: "TODO: mini paaiškinimas",
      leading: IconButton(
        icon: Icon(
          Icons.help_outline_outlined,
        ),
        onPressed: () => showInformationDialog(context),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TODO fix"),
          ],
        )
      ],
    );
  }

  showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("TODO: Informacija"),
          content: Text("O Giedre cia jau sugalvok :)"),
          actions: [
            FlatButton(
              child: Text("GERAI"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

class ProductKindIcon extends StatelessWidget {
  final ProductKind productKind;

  const ProductKindIcon({Key key, @required this.productKind})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = (productKind == ProductKind.drink)
        ? Icons.local_cafe
        : Icons.local_dining;

    return IconButton(
      icon: Icon(
        icon,
        size: 24,
      ),
      onPressed: null,
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
      title: Text(product.name),
      contentPadding: EdgeInsets.zero,
      subtitle: Text(
        dateFormat.format(intake.dateTime).capitalizeFirst(),
      ),
      leading: ProductKindIcon(productKind: product.kind),
      trailing: Text("${intake.amountG} g"),
    );
  }
}
