import 'package:async/async.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'error_state.dart';

class AppFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() future;
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
  _AppFutureBuilderState<T> createState() => _AppFutureBuilderState<T>();
}

class _AppFutureBuilderState<T> extends State<AppFutureBuilder<T>> {
  var _futureMemoizer = AsyncMemoizer<T>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _futureMemoizer.runOnce(() => widget.future()),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return widget.builder(context, snapshot.requireData);
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

  void _retry() {
    setState(() => _futureMemoizer = AsyncMemoizer<T>());
  }

  Widget _buildError(BuildContext context, AsyncSnapshot<T> snapshot) {
    final errorChild = ErrorStateWidget(
      errorText: snapshot.error.toString(),
      retry: _retry,
    );

    if (widget.loadingAndErrorWrapper == null) {
      return errorChild;
    } else {
      return widget.loadingAndErrorWrapper!(context, errorChild);
    }
  }

  Widget _buildLoading(BuildContext context) {
    const loadingChild = Center(child: CircularProgressIndicator());

    if (widget.loadingAndErrorWrapper == null) {
      return loadingChild;
    } else {
      return widget.loadingAndErrorWrapper!(context, loadingChild);
    }
  }
}
