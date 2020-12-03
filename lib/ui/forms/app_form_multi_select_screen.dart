import 'package:flutter/material.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/extensions/CollectionExtensions.dart';

class AppFormMultipleSelectScreenData<T> {
  final String title;
  final List<AppSelectFormFieldItem<T>> items;
  final List<AppSelectFormFieldItem<T>> selectedItems;

  const AppFormMultipleSelectScreenData({
    this.title,
    @required this.items,
    this.selectedItems,
  });
}

class AppFormMultipleSelectScreen<T> extends StatefulWidget {
  final AppFormMultipleSelectScreenData<T> data;

  const AppFormMultipleSelectScreen({Key key, @required this.data})
      : super(key: key);

  @override
  _AppFormMultipleSelectScreenState<T> createState() =>
      _AppFormMultipleSelectScreenState<T>();
}

class _AppFormMultipleSelectScreenState<T>
    extends State<AppFormMultipleSelectScreen<T>> {
  List<bool> _itemsSelection;

  @override
  void initState() {
    super.initState();

    _itemsSelection = widget.data.items
        .map((e) =>
            widget.data.selectedItems
                .firstWhere((s) => e.value == s.value, orElse: () => null) !=
            null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context, _getSelectedItems()),
        label: Text("PASIRINKTI"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          padding: EdgeInsets.zero,
          child: Column(
            children: widget.data.items
                .mapIndexed((item, i) => _generateItemCell(context, item, i))
                .toList(),
          ),
        ),
      ),
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
        onChanged: (b) => onTap(index),
      ),
      selected: selected,
      onTap: () => onTap(index),
    );
  }

  onTap(int index) {
    setState(() {
      _itemsSelection[index] ^= true;
    });
  }

  List<AppSelectFormFieldItem<T>> _getSelectedItems() {
    List<AppSelectFormFieldItem<T>> selectedItems = [];
    for (int i = 0; i < _itemsSelection.length; ++i) {
      if (_itemsSelection[i]) {
        selectedItems.add(widget.data.items[i]);
      }
    }

    return selectedItems;
  }
}
