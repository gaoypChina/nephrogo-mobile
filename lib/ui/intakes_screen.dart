import 'package:flutter/material.dart';
import 'package:nephrolog/models/intake.dart';

class IntakesScreenArguments {
  final Indicator indicator;

  IntakesScreenArguments(this.indicator);
}

class IntakesScreen extends StatelessWidget {
  final Indicator indicator;

  const IntakesScreen({Key key, @required this.indicator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nephrolog"),
        centerTitle: true,
      ),
      body: IntakesScreenBody(
        indicator: indicator,
      ),
    );
  }
}

class IntakesScreenBody extends StatelessWidget {
  final Indicator indicator;

  const IntakesScreenBody({Key key, @required this.indicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("$indicator");
  }
}
