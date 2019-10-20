import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'progress_dialog.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot, ProgressDialog loadingDialog);

class StreamLoading<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  final ProgressDialog loadingDialog;

  const StreamLoading({
    Key key,
    this.initialData,
    Stream<T> stream,
    this.loadingDialog,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key, stream: stream);

  final AsyncWidgetBuilder<T> builder;

  final T initialData;

  @override
  AsyncSnapshot<T> initial() => AsyncSnapshot<T>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) => current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) =>
      AsyncSnapshot<T>.withData(ConnectionState.active, data);

  @override
  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) =>
      AsyncSnapshot<T>.withError(ConnectionState.active, error);

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) => current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) => current.inState(ConnectionState.none);

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) {
    if (currentSummary.connectionState != ConnectionState.active && loadingDialog != null) {
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        loadingDialog.show();
      });
    }

    return builder(context, currentSummary, loadingDialog);
  }
}
