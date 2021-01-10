import 'package:flutter/material.dart';
import 'package:nephrolog/api/api_service.dart';

enum AppStateChangeEvent { healthStatus, nutrition }

class AppStateChangeStreamBuilder extends StatelessWidget {
  final _apiService = ApiService();

  final Widget Function(BuildContext context) builder;
  final AppStateChangeEvent event;

  AppStateChangeStreamBuilder({
    Key key,
    @required this.builder,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: event,
      stream: _apiService.appEventsStream.where((e) => e == event),
      builder: (context, snapshot) {
        print("StreamBuilder ${snapshot.connectionState}");
        return builder(context);
      },
    );
  }
}
