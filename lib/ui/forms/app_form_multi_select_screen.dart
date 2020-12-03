import 'package:flutter/material.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms/forms.dart';

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
  List<AppSelectFormFieldItem<T>> _selectedItems;

  @override
  void initState() {
    super.initState();

    _selectedItems = [...widget.data.selectedItems];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context, _selectedItems),
        label: Text("PASIRINKTI"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          padding: EdgeInsets.zero,
          child: Column(
            children: widget.data.items
                .map((item) => _generateItemCell(context, item))
                .toList(),
          ),
        ),
      ),
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item) {
    final selected = _selectedItems.firstWhere((e) => e.value == item.value,
            orElse: () => null) !=
        null;

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
        onChanged: null,
      ),
      selected: selected,
      onTap: () {
        setState(() {
          if (selected) {
            _selectedItems.remove(item);
          } else {
            _selectedItems.add(item);
          }
        });
      },
    );
  }
}
