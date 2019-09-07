import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

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
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) {
    if (current.connectionState != ConnectionState.active && !loadingDialog.isShowing()) {
      PageNavigator.runOnUI((_) {
        loadingDialog.show();
      });
    }
    return super.afterConnected(current);
  }

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    if (loadingDialog.isShowing()) {
      PageNavigator.runOnUI((_) async {
        await Future.delayed(Duration(seconds: 1)); // for dialog shown
        loadingDialog.hide();
      });
    }
    return super.afterData(current, data);
  }

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> currentSummary) {
    return StreamBuilder<T>(stream: stream, builder: (context, snapshot) => builder(context, snapshot));
  }
}
