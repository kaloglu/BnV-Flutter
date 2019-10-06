import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'progress_dialog.dart';

class StreamLoading<T> extends StreamBuilder<T> {
  final T initialData;
  final AsyncWidgetBuilder<T> builder;
  final ProgressDialog loadingDialog;

  const StreamLoading({
    Key key,
    @required this.loadingDialog,
    Stream<T> stream,
    @required this.builder,
    this.initialData,
  }) : super(key: key, stream: stream, initialData: initialData, builder: builder);

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) {
    if (currentSummary.connectionState == ConnectionState.active && loadingDialog.isShowing()) {
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        loadingDialog.hide();
      });
    }
    if (currentSummary.connectionState != ConnectionState.active && !loadingDialog.isShowing()) {
      SchedulerBinding.instance.addPostFrameCallback((duration) {
        loadingDialog.show();
      });
    }
    return super.build(context, currentSummary);
  }
}
