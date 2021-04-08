import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'error_state.dart';

class AppFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Widget child)?
      loadingAndErrorWrapper;

  const AppFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingAndErrorWrapper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return builder(context, snapshot.requireData);
        } else if (snapshot.hasError) {
          FirebaseCrashlytics.instance.recordError(
            snapshot.error,
            snapshot.stackTrace,
          );

          return _buildError(context, snapshot);
        } else {
          return _buildLoading(context);
        }
      },
    );
  }

  Widget _buildError(BuildContext context, AsyncSnapshot<T> snapshot) {
    final errorChild = ErrorStateWidget(errorText: snapshot.error.toString());

    if (loadingAndErrorWrapper == null) {
      return errorChild;
    } else {
      return loadingAndErrorWrapper!(context, errorChild);
    }
  }

  Widget _buildLoading(BuildContext context) {
    const loadingChild = Center(child: CircularProgressIndicator());

    if (loadingAndErrorWrapper == null) {
      return loadingChild;
    } else {
      return loadingAndErrorWrapper!(context, loadingChild);
    }
  }
}
