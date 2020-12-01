import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/StringExtension.dart';
import 'package:nephrolog/models/intake.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/intakes_screen.dart';

import 'graph.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DailyNormsSection(),
            DailyIntakesCard(
              title: "Valgiai",
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.potassium),
              ),
              intakes: Intake.generateDummies(n: 3).toList(),
            ),
            SectionCard(
              title: "Kalis",
              subTitle: "Paros norma 4 g",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.potassium),
              ),
            ),
            SectionCard(
              title: "Baltymai",
              subTitle: "Paros norma 1.1 g",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.proteins),
              ),
            ),
            SectionCard(
              title: "Natris",
              subTitle: "Paros norma 2.3 g",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.sodium),
              ),
            ),
            SectionCard(
              title: "Fosforas",
              subTitle: "Paros norma 5 g",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.phosphorus),
              ),
            ),
            SectionCard(
              title: "Energija",
              subTitle: "Paros norma 2800 kcal",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.energy),
              ),
            ),
            SectionCard(
              title: "Skysčiai",
              subTitle: "Paros norma 1100 ml",
              child: BarChartGraph.exampleIndicatorGraph(),
              leading: OutlineButton(
                child: Text("DAUGIAU"),
                onPressed: () =>
                    openIntakesScreen(context, IntakesScreenType.liquids),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openIntakesScreen(BuildContext context, IntakesScreenType indicator) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_INTAKES,
      arguments: IntakesScreenArguments(indicator),
    );
  }
}

class DailyNormsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: "Paros normos",
      subTitle: "TODO: mini paaiškinimas",
      leading: IconButton(
        icon: Icon(
          Icons.help_outline_outlined,
        ),
        onPressed: () => showInformationDialog(context),
      ),
      child: BarChartGraph.exampleDailyTotals(),
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

class SectionCard extends StatelessWidget {
  final Widget child;
  final String title;
  final String subTitle;
  final Widget leading;

  const SectionCard({
    Key key,
    @required this.title,
    @required this.child,
    this.subTitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (this.subTitle != null)
                          Text(
                            this.subTitle,
                            style: TextStyle(
                              color: const Color(0xff379982),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (leading != null) leading
                ],
              ),
              child,
            ],
          ),
        ),
      ),
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

    final dividedIntakeTiles = ListTile.divideTiles(
      context: context,
      tiles: intakeTiles,
    ).toList();

    return SectionCard(
      title: title,
      subTitle: subTitle,
      leading: leading,
      child: Column(
        children: dividedIntakeTiles,
      ),
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
