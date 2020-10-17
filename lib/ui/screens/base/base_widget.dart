import 'package:BedavaNeVar/viewmodels/base/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<VM extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, VM viewModel, Widget child) builder;
  final VM viewModel;
  final Widget child;
  final Function(VM) onModelReady;

  BaseWidget({
    Key key,
    this.builder,
    this.viewModel,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _BaseWidgetState<VM> createState() => _BaseWidgetState<VM>();
}

class _BaseWidgetState<VM extends BaseViewModel> extends State<BaseWidget<VM>> {
  VM viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>.value(
      value: viewModel,
      child: Consumer<VM>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void initState() {
    viewModel = widget.viewModel;

    if (widget.onModelReady != null) {
      widget.onModelReady(viewModel);
    }

    super.initState();
  }
}

class BaseWidget2<VM extends BaseViewModel, O extends Object> extends StatefulWidget {
  final Widget Function(BuildContext context, VM viewModel, O object, Widget child) builder;
  final VM viewModel;
  final O object;
  final Widget child;
  final Function(VM, O) onModelReady;

  BaseWidget2({
    Key key,
    this.builder,
    this.viewModel,
    this.object,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _BaseWidgetState2<VM, O> createState() => _BaseWidgetState2<VM, O>();
}

class _BaseWidgetState2<VM extends BaseViewModel, O extends Object> extends State<BaseWidget2<VM, O>> {
  VM viewModel;
  O object;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>.value(
      value: viewModel,
      child: Consumer2<VM, O>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void initState() {
    viewModel = widget.viewModel;

    if (widget.onModelReady != null) {
      widget.onModelReady(viewModel, object);
    }

    super.initState();
  }
}
