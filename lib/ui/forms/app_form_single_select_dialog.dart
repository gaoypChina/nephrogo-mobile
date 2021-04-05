import 'package:flutter/material.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';

class AppFormSingleSelectDialog<T> extends StatelessWidget {
  final List<AppSelectFormFieldItem> items;
  final String title;
  final T? selectedValue;
  final String? helpText;

  const AppFormSingleSelectDialog({
    Key? key,
    required this.items,
    required this.title,
    this.selectedValue,
    this.helpText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      scrollable: true,
      contentPadding: const EdgeInsets.only(top: 20),
      content: Column(
        children: [
          if (helpText != null)
            BasicSection(
              header: AppListTile(
                leading: const CircleAvatar(child: Icon(Icons.info_outline)),
                title: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    helpText!,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          BasicSection(
            margin: EdgeInsets.zero,
            showDividers: true,
            children: [
              for (final item in items) _generateItemCell(context, item)
            ],
          ),
        ],
      ),
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item) {
    final selected = selectedValue != null && item.value == selectedValue;

    final radioIconData =
        selected ? Icons.radio_button_on : Icons.radio_button_off;

    return AppListTile(
      title: Text(item.text),
      subtitle: item.description != null ? Text(item.description!) : null,
      leading: item.icon != null
          ? IconButton(
              color: selected ? Colors.teal : null,
              icon: item.icon!,
              onPressed: null,
            )
          : null,
      trailing: Icon(radioIconData, color: Colors.teal),
      selected: selected,
      onTap: () => Navigator.pop(context, item),
    );
  }
}
