import 'package:flutter/material.dart';
import 'package:nephrogo_api_client/model/product_kind_enum.dart';

class BasicSection extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry innerPadding;
  final bool showDividers;

  BasicSection({
    Key key,
    this.header,
    this.children = const [],
    this.showDividers = false,
    this.padding = const EdgeInsets.only(bottom: 16),
    this.innerPadding = EdgeInsets.zero,
  })  : assert(header != null || children.isNotEmpty,
            "Either header or at least one child should be passed"),
        super(key: key);

  const BasicSection.single(
    Widget child, {
    this.padding = const EdgeInsets.only(bottom: 16),
    this.innerPadding = EdgeInsets.zero,
  })
  // ignore: prefer_initializing_formals
  : header = child,
        children = const [],
        showDividers = false;

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
        child: Padding(
          padding: innerPadding,
          child: _buildHeaderAndChildren(context),
        ),
      ),
    );
  }

  Widget _buildHeaderAndChildren(BuildContext context) {
    if (children.isEmpty) {
      return header;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) header,
        ..._getPreparedChildren(context),
      ],
    );
  }

  Iterable<Widget> _getPreparedChildren(BuildContext context) {
    if (children.isEmpty || children.length == 1) {
      return children;
    }

    if (showDividers) {
      return ListTile.divideTiles(
        context: context,
        tiles: children,
      );
    }

    return children;
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
    this.showDividers = false,
  }) : super(key: key);

  Widget _buildSubtitle() {
    if (subTitle == null) {
      return null;
    }
    return Text(
      subTitle,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      showDividers: showDividers,
      header: AppListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: _buildSubtitle(),
        trailing: leading,
      ),
      children: children,
    );
  }
}

class SmallSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool showDividers;

  const SmallSection({
    Key key,
    @required this.children,
    @required this.title,
    this.showDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      showDividers: showDividers,
      header: AppListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.grey),
        ),
        dense: true,
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
  final bool dense;

  const AppListTile({
    Key key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is needed for workaround https://github.com/flutter/flutter/issues/3782
    return Material(
      color: Colors.white,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        dense: dense,
        trailing: trailing ??
            (onTap != null ? const Icon(Icons.chevron_right) : null),
        onTap: onTap,
        selected: selected,
      ),
    );
  }
}

class AppCheckboxListTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  final Widget title;
  final Widget subtitle;
  final bool dense;

  const AppCheckboxListTile({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.title,
    this.subtitle,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material is needed for workaround https://github.com/flutter/flutter/issues/3782
    return Material(
      color: Colors.white,
      child: CheckboxListTile(
        value: value,
        activeColor: Theme.of(context).primaryColor,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
        dense: dense,
      ),
    );
  }
}

class ProductKindIcon extends StatelessWidget {
  final ProductKindEnum productKind;

  ProductKindIcon({@required this.productKind})
      : super(key: ObjectKey(productKind));

  @override
  Widget build(BuildContext context) {
    final icon = (productKind == ProductKindEnum.drink)
        ? Icons.local_cafe
        : Icons.local_dining;

    return ExcludeSemantics(
      child: IconButton(
        icon: Icon(icon),
        onPressed: null,
      ),
    );
  }
}

class EmptyStateContainer extends StatelessWidget {
  final String text;

  const EmptyStateContainer({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/empty.png'),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
