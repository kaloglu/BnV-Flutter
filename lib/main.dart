import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/services/auth/auth_service_adapter.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(BedavaNeVarApp());
}

class BedavaNeVarApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return Provider<AuthService>(
      builder: (_) => AuthServiceAdapter(),
      dispose: (_, AuthService authService) => authService.dispose(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: PageNavigator.splash,
        onGenerateRoute: PageNavigator.onGenerateRoute,
      ),
    );
  }
}
