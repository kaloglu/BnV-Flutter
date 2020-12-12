import 'package:BedavaNeVar/BnvApp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((ref) => throw UnimplementedError());

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences)
      : onboardingPreferences = OnboardingPreferences(sharedPreferences: sharedPreferences),
        themePreferences = ThemePreferences(sharedPreferences: sharedPreferences);

  final SharedPreferences sharedPreferences;
  final OnboardingPreferences onboardingPreferences;
  final ThemePreferences themePreferences;
}

class OnboardingPreferences {
  final SharedPreferences sharedPreferences;
  static const completeKey = 'onboardingComplete';

  OnboardingPreferences({@required this.sharedPreferences});

  Future<void> setComplete() async {
    await sharedPreferences.setBool(completeKey, true);
  }

  bool isComplete() => sharedPreferences.getBool(completeKey) ?? false;
}

class ThemePreferences {
  final SharedPreferences sharedPreferences;
  static const modeKey = 'themeMode';

  ThemePreferences({@required this.sharedPreferences});

  Future<void> setMode(mode) async => await sharedPreferences.setString(modeKey, mode.toString());

  ThemeMode mode() {
    var mode = (sharedPreferences.getString(modeKey));
    switch (mode) {
      case "ThemeMode.light":
        return ThemeMode.light;
      case "ThemeMode.dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
