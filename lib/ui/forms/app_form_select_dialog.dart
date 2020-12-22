import 'package:flutter/material.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/components.dart';

class AppFormSelectDialog<T> extends StatelessWidget {
  final List<AppSelectFormFieldItem> items;
  final T selectedValue;
  final String title;
  final String helpText;

  const AppFormSelectDialog({
    Key key,
    @required this.items,
    this.title,
    this.selectedValue,
    this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      scrollable: true,
      contentPadding: EdgeInsets.only(top: 20),
      content: Column(
        children: [
          if (helpText != null)
            BasicSection(
              header: AppListTile(
                leading: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: null,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    helpText,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          BasicSection(
            padding: EdgeInsets.zero,
            children:
                items.map((item) => _generateItemCell(context, item)).toList(),
          ),
        ],
      ),
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item) {
    final selected = selectedValue != null && item.value == selectedValue;
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    final radioIconData =
    selected ? Icons.radio_button_on : Icons.radio_button_off;

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
      trailing: Icon(radioIconData, color: primaryColor),
      selected: selected,
      onTap: () => Navigator.pop(context, item),
    );
  }
}
