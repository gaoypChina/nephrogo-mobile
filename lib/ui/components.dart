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

class BasicSection extends StatelessWidget {
  final Widget child;

  const BasicSection({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: Divider.createBorderSide(context),
            bottom: Divider.createBorderSide(context),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: child,
        ),
      ),
    );
  }
}

class LargeSection extends StatelessWidget {
  final Widget child;
  final String title;
  final String subTitle;
  final Widget leading;

  const LargeSection({
    Key key,
    @required this.title,
    @required this.child,
    this.subTitle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection(
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
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (this.subTitle != null)
                      Text(
                        this.subTitle,
                        style: TextStyle(
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
    );
  }
}

class SmallSection extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool setLeftPadding;

  const SmallSection({
    Key key,
    @required this.child,
    @required this.title,
    this.setLeftPadding: false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerPadding = padding ?? const EdgeInsets.symmetric(vertical: 8);
    if (padding == null && setLeftPadding) {
      headerPadding = EdgeInsets.all(8);
    }

    return BasicSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: headerPadding,
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
