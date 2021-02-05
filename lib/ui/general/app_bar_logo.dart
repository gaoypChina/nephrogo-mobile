import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo() : super(key: const Key('AppBarLogo'));

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/logo.png',
      fit: BoxFit.scaleDown,
      height: kToolbarHeight * 0.65,
    );
  }
}
