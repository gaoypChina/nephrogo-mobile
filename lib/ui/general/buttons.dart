import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  final Color color;
  final Color textColor;
  final EdgeInsets innerPadding;

  const AppElevatedButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.color,
    this.textColor,
    this.innerPadding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        padding: innerPadding,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
