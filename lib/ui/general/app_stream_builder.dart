import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'error_state.dart';

class AppStreamBuilder<T> extends StatefulWidget {
  final Stream<T> Function() stream;
  final Widget Function(BuildContext context, T data) builder;

  const AppStreamBuilder({
    Key? key,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  @override
  _AppStreamBuilderState<T> createState() => _AppStreamBuilderState<T>();
}

class _AppStreamBuilderState<T> extends State<AppStreamBuilder<T>> {
  late Stream<T> stream = widget.stream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            FirebaseCrashlytics.instance.recordError(
              snapshot.error,
              snapshot.stackTrace,
            );

            return ErrorStateWidget(
              errorText: snapshot.error.toString(),
              retry: () => setState(() => stream = widget.stream()),
            );
          }

          if (snapshot.hasData) {
            return widget.builder(context, snapshot.requireData);
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
