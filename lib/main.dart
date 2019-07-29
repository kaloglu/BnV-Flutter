import 'package:bnv/services/auth/auth_service_adapter.dart';
import 'package:bnv/services/db/firestore_service_adapter.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/services/interfaces/db_service.dart';
import 'package:bnv/services/notifications/firebase_notifications.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(BedavaNeVarApp());
}

class BedavaNeVarApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FirebaseNotifications().setup();
    return MultiProvider(providers: [
      Provider<AuthService>(
        builder: (_) => AuthServiceAdapter(),
        dispose: (_, AuthService authService) => authService.dispose(),
      ),
      Provider<DBService>(
        builder: (_) => DBServiceAdapter(),
        dispose: (_, DBService dbService) => dbService.dispose(),
      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: PageNavigator.splash,
        onGenerateRoute: PageNavigator.onGenerateRoute,
      ),);
  }
}
