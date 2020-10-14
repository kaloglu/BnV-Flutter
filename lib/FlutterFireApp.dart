import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/provider_setup.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_alert_dialog.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = true;

class FlutterFireApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return PlatformAlertDialog(
            title: "Firebase Error",
            content: snapshot.error,
            defaultActionText: "OK",
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
          // turn this off after seeing reports in in the console.
          FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

          if (USE_FIRESTORE_EMULATOR) {
            // Switch host based on platform.
            FirebaseFirestore.instance.settings = Settings(
              host: defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2:8080' : 'localhost:8080',
              sslEnabled: false,
              persistenceEnabled: false,
            );
          }
          return MultiProvider(providers: providers, child: BnVApp());
        }
        return Container(
          child: Text("Loading..."),
        );
      },
    );
  }
}
