import 'package:flutter/material.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;

  const AppFutureBuilder({Key key, this.future, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}
