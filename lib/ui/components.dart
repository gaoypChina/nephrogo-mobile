import 'package:flutter/material.dart';

class SmallSectionHeader extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const SmallSectionHeader({
    Key key,
    this.text,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
