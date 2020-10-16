import 'package:BedavaNeVar/ui/widgets/common/progress_dialog.dart';
import 'package:flutter/material.dart';

import 'progress_dialog.dart';

typedef AsyncWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot /*, ProgressDialog loadingDialog*/);

class StreamLoading<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  // final ProgressDialog _loadingDialog;
  // final BuildContext context;

  StreamLoading({
    Key key,
    // this.context,
    this.initialData,
    Stream<T> stream,
    ProgressDialog loadingDialog,
    @required this.builder,
  })  : assert(builder != null),
        // assert(context != null),
        // _loadingDialog = loadingDialog ?? ProgressDialog(context: context),
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
    // if (_loadingDialog != null) {
    //   SchedulerBinding.instance.addPostFrameCallback((duration) {
    //     if (currentSummary.connectionState != ConnectionState.active) {
    //       _loadingDialog.show();
    //     } else {
    //       _loadingDialog.hide();
    //     }
    //   });
    // }

    return builder(context, currentSummary /*, _loadingDialog*/);
  }
}
