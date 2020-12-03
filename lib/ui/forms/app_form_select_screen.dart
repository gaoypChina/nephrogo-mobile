import 'package:flutter/material.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms.dart';

class AppFromSelectScreenData<T> {
  final String title;
  final List<AppSelectFormFieldItem> items;
  final T selectedValue;

  const AppFromSelectScreenData({
    this.title,
    @required this.items,
    this.selectedValue,
  });
}

class AppFromSelectScreen<T> extends StatelessWidget {
  final AppFromSelectScreenData<T> data;

  const AppFromSelectScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: SingleChildScrollView(
        child: BasicSection(
          padding: EdgeInsets.zero,
          child: Column(
            children: data.items
                .map((item) => _generateItemCell(context, item))
                .toList(),
          ),
        ),
      ),
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item) {
    final selected =
        data.selectedValue != null && item.value == data.selectedValue;
    final primaryColor = Theme.of(context).primaryColor;

    final iconData = selected ? Icons.radio_button_on : Icons.radio_button_off;

    return AppListTile(
      title: Text(item.title),
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
      trailing: Icon(iconData, color: primaryColor),
      selected: selected,
      onTap: () => Navigator.pop(context, item),
    );
  }
}
