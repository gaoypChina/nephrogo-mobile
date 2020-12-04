import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  final Color color;

  const AppProgressIndicator({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
