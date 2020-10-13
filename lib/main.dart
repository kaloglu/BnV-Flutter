import 'package:BedavaNeVar/provider_setup.dart';
import 'package:BedavaNeVar/ui/screens/splash_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_alert_dialog.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'constants/constants.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = true;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(FlutterFireApp());
}

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
        return BnVApp(route: SplashScreenScreen.route);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Hello World'),
    );
  }
}

class BnVApp extends StatelessWidget {
  final String _route;

  BnVApp({Key key, route})
      : _route = route ?? ScreenNavigator.initialRoute,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        shadowColor: kShadowColor,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: kTitleTextColor),
          bodyText2: TextStyle(color: kBodyTextColor),
        ),
      ),
      initialRoute: _route,
      onGenerateRoute: ScreenNavigator.onGenerateRoute,
//        onGenerateRoute: ScreenNavigator.getFadeRoute,
    );
  }
}
