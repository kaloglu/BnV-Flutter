import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _firebaseEmulator();
  await _initCrashlytics();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      )
    ],
    child: BnVApp(),
  ));
}

Future<void> _initCrashlytics() async {
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // turn this off after seeing reports in in the console.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

Future<void> _firebaseEmulator() async {
  if (USE_FIRESTORE_EMULATOR) {
    // Switch host based on platform.
    FirebaseFirestore.instance.settings = Settings(
      host: defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2:8080' : 'localhost:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }
}
