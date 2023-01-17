import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class SpeedDialFloatingActionButton extends StatefulWidget {
  final String label;
  final List<SpeedDialChild> children;
  final VoidCallback? onPress;
  final IconData icon;

  const SpeedDialFloatingActionButton({
    super.key,
    required this.label,
    this.onPress,
    this.icon = Icons.add,
    this.children = const [],
  });

  @override
  _SpeedDialFloatingActionButtonState createState() =>
      _SpeedDialFloatingActionButtonState();
}

class _SpeedDialFloatingActionButtonState
    extends State<SpeedDialFloatingActionButton> {
  late ValueNotifier<bool> _isDialOpen;

  @override
  void initState() {
    super.initState();

    _isDialOpen = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isDialOpen.value) {
          _isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: SpeedDial(
        overlayOpacity: 0.9,
        openCloseDial: _isDialOpen,
        icon: widget.icon,
        activeIcon: Icons.close,
        backgroundColor: Colors.redAccent,
        label: Text(
          widget.label.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        children: widget.children,
        onPress: widget.onPress,
      ),
    );
  }

  @override
  void dispose() {
    _isDialOpen.dispose();

    super.dispose();
  }
}

class BasicSection extends StatelessWidget {
  final Widget? header;
  final Widget? footer;
  final List<Widget> children;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry innerPadding;
  final bool showDividers;
  final bool showHeaderDivider;
  final CrossAxisAlignment crossAxisAlignment;

  BasicSection({
    super.key,
    this.header,
    this.footer,
    this.children = const [],
    this.showDividers = false,
    this.showHeaderDivider = false,
    EdgeInsetsGeometry? margin,
    this.innerPadding = EdgeInsets.zero,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : assert(
          header != null || children.isNotEmpty,
          'Either header or at least one child should be passed',
        ),
        assert(!showHeaderDivider || (showHeaderDivider && header != null)),
        margin = margin ?? const EdgeInsets.only(bottom: 16);

  const BasicSection.single({
    required Widget child,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.innerPadding = EdgeInsets.zero,
    this.footer,
  })
  // ignore: prefer_initializing_formals
  : header = child,
        children = const [],
        showHeaderDivider = false,
        showDividers = false,
        crossAxisAlignment = CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: const RoundedRectangleBorder(),
      clipBehavior: Clip.none,
      elevation: 0,
      child: Padding(
        padding: innerPadding,
        child: _buildHeaderAndChildren(context),
      ),
    );
  }

  Widget _buildHeaderAndChildren(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: _getPreparedChildren(context).toList(),
    );
  }

  Iterable<Widget> _getPreparedChildren(BuildContext context) sync* {
    if (header != null) {
      yield header!;

      if (showHeaderDivider && children.isNotEmpty) {
        yield const Divider(height: 1);
      }
    }

    if (showDividers && children.isNotEmpty) {
      yield* ListTile.divideTiles(
        context: context,
        tiles: children,
      );
    } else {
      yield* children;
    }

    if (footer != null) {
      yield const Divider(height: 1);
      yield footer!;
    }
  }
}

class LargeSection extends StatelessWidget {
  final List<Widget> children;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final bool isThreeLine;
  final GestureTapCallback? onTap;

  const LargeSection({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.trailing,
    this.footer,
    this.onTap,
    this.isThreeLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      showDividers: true,
      showHeaderDivider: true,
      header: LargeAppListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        isThreeLine: isThreeLine,
      ),
      footer: footer,
      children: children,
    );
  }
}

class SmallSection extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final List<Widget> children;
  final bool showDividers;
  final EdgeInsets innerPadding;

  const SmallSection({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
    this.showDividers = false,
    this.innerPadding = const EdgeInsets.only(bottom: 4),
  });

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      showDividers: showDividers,
      header: AppListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey),
        ),
        trailing: trailing,
        dense: true,
      ),
      innerPadding: innerPadding,
      children: children,
    );
  }
}

class LargeAppListTile extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final bool isThreeLine;

  const LargeAppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isThreeLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: getTitleWithStyleApplied(context),
      subtitle: getSubtitleWithStyleApplied(context),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      isThreeLine: isThreeLine,
    );
  }

  Widget getTitleWithStyleApplied(BuildContext context) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.titleLarge,
      child: title,
    );
  }

  Widget? getSubtitleWithStyleApplied(BuildContext context) {
    if (subtitle == null) {
      return null;
    }

    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.titleSmall,
      child: subtitle!,
    );
  }
}

class AppListTile extends StatelessWidget {
  final Widget title;

  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final bool selected;
  final bool dense;
  final bool isThreeLine;
  final EdgeInsetsGeometry? contentPadding;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.contentPadding,
    this.selected = false,
    this.dense = false,
    this.isThreeLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      contentPadding: contentPadding,
      dense: dense,
      isThreeLine: isThreeLine,
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
      selected: selected,
    );
  }
}

class AppExpansionTile extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final Widget? subtitle;
  final List<Widget> children;

  final bool initiallyExpanded;

  final GestureLongPressCallback? onLongPress;

  const AppExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.onLongPress,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    // Material is needed for workaround https://github.com/flutter/flutter/issues/3782
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: Theme.of(context).dialogBackgroundColor,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            leading: leading,
            title: DefaultTextStyle.merge(
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              child: title,
            ),
            subtitle: _getSubtitle(context),
            children: children,
          ),
        ),
      ),
    );
  }

  Widget? _getSubtitle(BuildContext context) {
    if (subtitle == null) {
      return null;
    }

    return DefaultTextStyle.merge(
      style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
      child: subtitle!,
    );
  }
}

class AppCheckboxListTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  final Widget title;
  final Widget? subtitle;
  final bool dense;

  const AppCheckboxListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    // Material is needed for workaround https://github.com/flutter/flutter/issues/3782
    return Material(
      color: Theme.of(context).dialogBackgroundColor,
      child: CheckboxListTile(
        value: value,
        activeColor: Colors.teal,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: _onChanged,
        title: title,
        subtitle: subtitle,
        dense: dense,
      ),
    );
  }

  void _onChanged(bool? b) {
    onChanged(b ?? false);
  }
}

class ProductKindIcon extends StatelessWidget {
  final ProductKindEnum productKind;

  ProductKindIcon({required this.productKind})
      : super(key: ObjectKey(productKind));

  @override
  Widget build(BuildContext context) {
    final icon = (productKind == ProductKindEnum.drink)
        ? Icons.local_cafe
        : Icons.local_dining;

    return ExcludeSemantics(child: CircleAvatar(child: Icon(icon)));
  }
}

class EmptyStateContainer extends StatelessWidget {
  final String text;

  const EmptyStateContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/empty.png',
              excludeFromSemantics: true,
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}

class AppBarTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AppBarTextButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      onPressed: onPressed,
      child: child,
    );
  }
}

class TextWithLeadingIcon extends StatelessWidget {
  final Text text;
  final IconData icon;
  final String? semanticLabel;

  const TextWithLeadingIcon({
    super.key,
    required this.text,
    required this.icon,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            icon,
            semanticLabel: semanticLabel,
            size: 14,
          ),
        ),
        text
      ],
    );
  }
}

class AppRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final EdgeInsetsGeometry? contentPadding;
  final ListTileControlAffinity controlAffinity;

  const AppRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.secondary,
    this.subtitle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: title,
      subtitle: subtitle,
      secondary: _leadingWithStyle(secondary),
      controlAffinity: controlAffinity,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: contentPadding,
    );
  }

  Widget? _leadingWithStyle(Widget? leading) {
    if (leading == null) {
      return null;
    }

    return DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.bold),
      child: leading,
    );
  }
}

class RadioButtonGroup<T> extends StatefulWidget {
  final ValueChanged<T?> onChanged;

  final List<AppRadioListTile<T>> Function(
    BuildContext context,
    ValueChanged<T?> onChanged,
  ) buildRadioGroups;

  const RadioButtonGroup({
    super.key,
    required this.onChanged,
    required this.buildRadioGroups,
  });

  @override
  _RadioButtonGroupState<T> createState() => _RadioButtonGroupState<T>();
}

class _RadioButtonGroupState<T> extends State<RadioButtonGroup<T>> {
  @override
  Widget build(BuildContext context) {
    final radioListTiles = widget.buildRadioGroups(
      context,
      _onChanged,
    );

    return Column(
      children: ListTile.divideTiles(
        context: context,
        tiles: radioListTiles,
      ).toList(),
    );
  }

  void _onChanged(T? value) {
    setState(() {
      widget.onChanged(value);
    });
  }
}
