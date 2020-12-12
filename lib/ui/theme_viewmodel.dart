import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeViewModelProvider = StateNotifierProvider<_ThemeViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return _ThemeViewModel(sharedPreferencesService.themePreferences);
});

ValueNotifier<ThemeMode> useThemeListener() {
  final viewModel = useProvider(themeViewModelProvider);
  final _themeMode = useState(viewModel.mode);

  useEffect(
    () => viewModel.mode$.listen((mode) => _themeMode.value = mode).cancel,
    [viewModel.mode$],
  );
  return _themeMode;
}

class _ThemeViewModel extends StateNotifier<ThemeMode> {
  _ThemeViewModel(this.themePreferences) : super(themePreferences.mode());
  final ThemePreferences themePreferences;

  Future<void> setMode(ThemeMode mode) async {
    await themePreferences.setMode(mode);
    state = mode;
  }

  ThemeMode get mode => state;

  Stream<ThemeMode> get mode$ => stream;
}
