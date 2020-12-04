import 'package:flutter/material.dart';

class BasicSection extends StatelessWidget {
  static const _defaultChildrenPadding =
      const EdgeInsets.symmetric(vertical: 4, horizontal: 16);

  static const _defaultHeaderPadding =
      const EdgeInsets.only(bottom: 4, top: 16, left: 16, right: 16);

  final Widget header;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final bool showDividers;

  const BasicSection({
    Key key,
    @required this.children,
    this.header,
    this.showDividers = true,
    this.padding = const EdgeInsets.only(bottom: 18.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: Divider.createBorderSide(context),
            bottom: Divider.createBorderSide(context),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null)
              Padding(
                padding: _defaultHeaderPadding,
                child: header,
              ),
            ..._getPreparedChildren(context),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> _getPreparedChildren(BuildContext context) {
    Iterable<Widget> preparedChildren = children.map(
      (c) => Padding(
        padding: _defaultChildrenPadding,
        child: c,
      ),
    );

    if (showDividers) {
      preparedChildren = ListTile.divideTiles(
        context: context,
        tiles: preparedChildren,
      );
    }

    return preparedChildren;
  }
}

class LargeSection extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final String subTitle;
  final Widget leading;
  final bool showDividers;

  const LargeSection({
    Key key,
    @required this.title,
    @required this.children,
    this.subTitle,
    this.leading,
    this.showDividers: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      showDividers: showDividers,
      header: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
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
      children: children,
    );
  }
}

class SmallSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final bool setLeftPadding;
  final bool showDividers;

  const SmallSection({
    Key key,
    @required this.children,
    @required this.title,
    this.setLeftPadding: false,
    this.padding,
    this.showDividers: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerPadding = padding ?? const EdgeInsets.symmetric(vertical: 8);
    if (padding == null && setLeftPadding) {
      headerPadding = EdgeInsets.all(8);
    }

    return BasicSection(
      showDividers: showDividers,
      header: Padding(
        padding: headerPadding,
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.grey,
              ),
        ),
      ),
      children: children,
    );
  }
}

class AppListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final GestureTapCallback onTap;
  final bool selected;

  const AppListTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing ?? (onTap != null ? Icon(Icons.chevron_right) : null),
      onTap: onTap,
      selected: selected,
    );
  }
}
