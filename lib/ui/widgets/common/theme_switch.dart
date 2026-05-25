import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget useThemeModeSwitch(BuildContext context) {
  var _themeViewModel = useProvider(themeViewModelProvider);
  return Switch(
    hoverColor: Colors.blue,
    value: useThemeListener().value != ThemeMode.light,
    onChanged: (value) => _themeViewModel.setMode(value ? ThemeMode.dark : ThemeMode.light),
  );
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
