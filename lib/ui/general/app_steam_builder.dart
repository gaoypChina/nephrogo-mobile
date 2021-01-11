import 'package:flutter/material.dart';
import 'package:nephrogo/ui/general/progress_indicator.dart';

class AppStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;

  const AppStreamBuilder({Key key, this.stream, this.builder})
      : assert(stream != null, "Steam can not be null"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return builder(context, snapshot.data);
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}
