import 'package:flutter/material.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;

  const AppFutureBuilder({Key key, this.future, this.builder})
      : assert(future != null, "Future can not be null"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text(snapshot.error.toString()));
          }

          return builder(context, snapshot.data);
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}
