import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'error_state.dart';

class AppStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;

  const AppStreamBuilder({
    Key? key,
    required this.stream,
    required this.builder,
  }) : super(key: key);

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

            return ErrorStateWidget(errorText: snapshot.error.toString());
          }

          // if (snapshot.hasData) {
          // ignore: null_check_on_nullable_type_parameter
          return builder(context, snapshot.data!);
          // }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
