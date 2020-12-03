import 'package:flutter/material.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms.dart';

class AppFromSelectScreenData {
  final String title;
  final List<AppSelectFormFieldItem> items;

  const AppFromSelectScreenData({this.title, @required this.items});
}

class AppFromSelectScreen extends StatelessWidget {
  final AppFromSelectScreenData data;

  const AppFromSelectScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: BasicSection(
        padding: EdgeInsets.zero,
        child: Column(
          children: data.items
              .map((item) => _generateItemCell(context, item))
              .toList(),
        ),
      ),
    );
  }

  AppListTile _generateItemCell(
      BuildContext context, AppSelectFormFieldItem item) {
    return AppListTile(
      title: Text(item.title),
      subtitle: item.description != null ? Text(item.description) : null,
      leading: item.icon != null
          ? IconButton(
              icon: Icon(
                item.icon,
              ),
              onPressed: null,
            )
          : null,
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.pop(context, item),
    );
  }
}
