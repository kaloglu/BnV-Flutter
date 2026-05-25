import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../BnvApp.dart';

final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>(
  (ref) => throw UnimplementedError(),
);

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;
  final OnboardingPreferences onboarding;
  final ThemePreferences theme;

  SharedPreferencesService(this.sharedPreferences)
      : onboarding = OnboardingPreferences._init(sharedPrefs: sharedPreferences),
        theme = ThemePreferences._init(sharedPrefs: sharedPreferences);
}

class OnboardingPreferences {
  final SharedPreferences sharedPrefs;
  static const completeKey = 'onboardingComplete';

  const OnboardingPreferences._init({@required this.sharedPrefs});

  get isComplete => sharedPrefs.getBool(completeKey) ?? false;

  Future<void> complete() async => await sharedPrefs.setBool(completeKey, true);
}

class ThemePreferences {
  final SharedPreferences sharedPrefs;
  final modeKey = ThemeModeValues.key;

  const ThemePreferences._init({@required this.sharedPrefs});

  get mode {
    var mode = ThemeMode.system;

    switch (sharedPrefs.getString(modeKey)) {
      case ThemeModeValues.light:
        mode = ThemeMode.light;
        break;
      case ThemeModeValues.dark:
        mode = ThemeMode.dark;
        break;
    }
    return mode;
  }

  Future<void> setMode(mode) async {
    return await sharedPrefs.setString(modeKey, mode.toString());
  }
}
