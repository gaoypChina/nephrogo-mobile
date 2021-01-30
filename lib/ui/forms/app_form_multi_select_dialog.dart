import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/collection_extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';

class AppFormMultipleSelectDialog<T> extends StatefulWidget {
  final String title;
  final List<AppSelectFormFieldItem<T>> items;
  final List<AppSelectFormFieldItem<T>> selectedItems;

  const AppFormMultipleSelectDialog({
    Key key,
    @required this.items,
    this.title,
    this.selectedItems,
  }) : super(key: key);

  @override
  _AppFormMultipleSelectDialogState<T> createState() =>
      _AppFormMultipleSelectDialogState<T>();
}

class _AppFormMultipleSelectDialogState<T>
    extends State<AppFormMultipleSelectDialog<T>> {
  List<bool> _itemsSelection;

  @override
  void initState() {
    super.initState();

    _itemsSelection = widget.items
        .map((e) =>
            widget.selectedItems
                .firstWhere((s) => e.value == s.value, orElse: () => null) !=
            null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(widget.title),
      scrollable: true,
      contentPadding: const EdgeInsets.only(top: 20),
      content: BasicSection(
        padding: EdgeInsets.zero,
        children: widget.items
            .mapIndexed((i, item) => _generateItemCell(context, item, i))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalizations.dialogCancel.toUpperCase()),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, _getSelectedItems());
          },
          child: Text(
            appLocalizations.formMultiSelectDialogActionChoose.toUpperCase(),
          ),
        ),
      ],
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item, int index) {
    final selected = _itemsSelection[index];

    final primaryColor = Theme.of(context).primaryColor;
    return AppListTile(
      title: Text(item.text),
      subtitle: item.description != null ? Text(item.description) : null,
      leading: item.icon != null
          ? IconButton(
              icon: Icon(
                item.icon,
                color: selected ? primaryColor : null,
              ),
              onPressed: null,
            )
          : null,
      trailing: Checkbox(
        value: selected,
        activeColor: primaryColor,
        onChanged: (b) => onTap(index),
      ),
      selected: selected,
      onTap: () => onTap(index),
    );
  }

  void onTap(int index) {
    setState(() {
      _itemsSelection[index] ^= true;
    });
  }

  List<AppSelectFormFieldItem<T>> _getSelectedItems() {
    final selectedItems = <AppSelectFormFieldItem<T>>[];
    for (var i = 0; i < _itemsSelection.length; ++i) {
      if (_itemsSelection[i]) {
        selectedItems.add(widget.items[i]);
      }
    }

    return selectedItems;
  }
}
