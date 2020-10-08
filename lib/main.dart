import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings =
        Settings(host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
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
        theme: ThemeData.dark(),
        initialRoute: ScreenNavigator.initialRoute,
        onGenerateRoute: ScreenNavigator.onGenerateRoute,
//        onGenerateRoute: ScreenNavigator.getFadeRoute,
      );
}
