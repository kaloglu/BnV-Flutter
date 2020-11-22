import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget useThemeModeSwitch(BuildContext context) {
  var _themeViewModel = useProvider(themeViewModelProvider);
  return Switch(
    hoverColor: Colors.blue,
    value: useThemeListener().value == ThemeMode.light,
    onChanged: (value) {
      _themeViewModel.setMode(value ? ThemeMode.light : ThemeMode.dark);
    },
  );
}
