import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/data/services/shared_preferences_service.dart';
import 'package:BedavaNeVar/firebase_options.dart';
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
  debugPrint('[main] initializeApp starting');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('[main] Firebase.initializeApp OK');

  await _firebaseEmulator();
  debugPrint('[main] _firebaseEmulator configured');
  await _initCrashlytics();
  debugPrint('[main] _initCrashlytics done');

  SharedPreferences sharedPreferences;
  try {
    sharedPreferences = await SharedPreferences.getInstance();
    debugPrint('[main] SharedPreferences ready');
  } catch (e) {
    debugPrint('[main] SharedPreferences init failed: $e');
    // Fallback: mock initial values to avoid MissingPluginException esp. on web
    try {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      sharedPreferences = await SharedPreferences.getInstance();
      debugPrint('[main] SharedPreferences fallback (mock) ready');
    } catch (e2) {
      debugPrint('[main] SharedPreferences fallback failed: $e2');
      rethrow;
    }
  }

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
  try {
    if (kIsWeb) {
      // Crashlytics web'de desteklenmez; sessizce atla
      debugPrint('[crashlytics] skipped on web');
      return;
    }
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  } catch (e) {
    debugPrint('[crashlytics] init failed: $e');
  }
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
