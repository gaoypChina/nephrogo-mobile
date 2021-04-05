import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/general/progress_indicator.dart';

import 'error_state.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;

  const AppFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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

        return const Center(child: AppProgressIndicator());
      },
    );
  }
}
