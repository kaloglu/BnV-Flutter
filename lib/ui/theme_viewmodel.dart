import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final themeViewModel = StateNotifierProvider<_ThemeViewModel>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);
  return _ThemeViewModel(sharedPreferencesService.themePreferences);
});

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
