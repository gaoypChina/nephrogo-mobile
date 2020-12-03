import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/StringExtension.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/tabs/nutrition/intakes_screen.dart';

import '../graph.dart';

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
          LargeSection(
            title: "Kalis",
            subTitle: "Paros norma 4 g",
            child: BarChartGraph.exampleIndicatorGraph(),
            leading: OutlineButton(
              child: Text("DAUGIAU"),
              onPressed: () =>
                  openIntakesScreen(context, IntakesScreenType.potassium),
            ),
          ),
          LargeSection(
            title: "Baltymai",
            subTitle: "Paros norma 1.1 g",
            child: BarChartGraph.exampleIndicatorGraph(),
            leading: OutlineButton(
              child: Text("DAUGIAU"),
              onPressed: () =>
                  openIntakesScreen(context, IntakesScreenType.proteins),
            ),
          ),
          LargeSection(
            title: "Natris",
            subTitle: "Paros norma 2.3 g",
            child: BarChartGraph.exampleIndicatorGraph(),
            leading: OutlineButton(
              child: Text("DAUGIAU"),
              onPressed: () =>
                  openIntakesScreen(context, IntakesScreenType.sodium),
            ),
          ),
          LargeSection(
            title: "Fosforas",
            subTitle: "Paros norma 5 g",
            child: BarChartGraph.exampleIndicatorGraph(),
            leading: OutlineButton(
              child: Text("DAUGIAU"),
              onPressed: () =>
                  openIntakesScreen(context, IntakesScreenType.phosphorus),
            ),
          ),
          LargeSection(
            title: "Energija",
            subTitle: "Paros norma 2800 kcal",
            child: BarChartGraph.exampleIndicatorGraph(),
            leading: OutlineButton(
              child: Text("DAUGIAU"),
              onPressed: () =>
                  openIntakesScreen(context, IntakesScreenType.energy),
            ),
          ),
          LargeSection(
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
    return LargeSection(
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
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: intakeTiles,
        ).toList(),
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
