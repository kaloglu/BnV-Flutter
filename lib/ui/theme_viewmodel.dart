import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeViewModelProvider = StateNotifierProvider<_ThemeViewModel, ThemeMode>(
  (ref) => _ThemeViewModel(ref.watch(sharedPreferencesServiceProvider).theme),
);

class _ThemeViewModel extends StateNotifier<ThemeMode> {
  _ThemeViewModel(this.themePreferences) : super(themePreferences.mode);
  final ThemePreferences themePreferences;

  Future<void> setMode(ThemeMode mode) async {
    await themePreferences.setMode(mode);
    state = mode;
  }

  ThemeMode get mode => state;
}
