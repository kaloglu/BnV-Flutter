import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
const bool USE_FIRESTORE_EMULATOR = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    // Switch host based on platform.
    String host = defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2:8080' : 'localhost:8080';
    FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false, persistenceEnabled: false);
  }
  runApp(BnVApp()
      // MultiProvider(
      //   providers: providers,
      //   child: BnVApp(),
      // ),
      );
}

class BnVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: ScreenNavigator.initialRoute,
        onGenerateRoute: ScreenNavigator.onGenerateRoute,
//        onGenerateRoute: ScreenNavigator.getFadeRoute,
      );
}
