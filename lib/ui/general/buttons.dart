import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;

  final Color? color;
  final Color? textColor;
  final EdgeInsets innerPadding;

  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.innerPadding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: innerPadding,
      ),
      onPressed: onPressed,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
        child: label,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget icon;
  final Color? textColor;

  final Color? color;
  final EdgeInsets innerPadding;

  const LoginButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
    this.textColor,
    this.innerPadding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: innerPadding,
      ),
      onPressed: onPressed,
      icon: icon,
      label: DefaultTextStyle(
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
        child: label,
      ),
    );
  }
}

class SectionFooterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const SectionFooterButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class ListFullWidthButton extends StatelessWidget {
  final Widget child;

  const ListFullWidthButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: child,
      ),
    );
  }
}
