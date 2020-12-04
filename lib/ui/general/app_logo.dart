import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/logo.png',
      fit: BoxFit.cover,
      height: 30,
    );
  }
}
