import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeViewModelProvider);
    final vm = ref.read(themeViewModelProvider.notifier);
    return Switch(
      hoverColor: Colors.blue,
      value: themeMode != ThemeMode.light,
      onChanged: (value) => vm.setMode(value ? ThemeMode.dark : ThemeMode.light),
    );
  }
}

List<BoxShadow> useShadowColors(
  BuildContext context, {
  double blurRadius = 15,
  double spreadRadius = -10,
  Offset offset = const Offset(8, 8),
}) =>
    [
      BoxShadow(
        spreadRadius: spreadRadius,
        color: Theme.of(context).shadowColor,
        blurRadius: blurRadius,
        offset: offset,
      )
    ];
