import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

Future main() async {
  runApp(BedavaNeVarApp());
}

class BedavaNeVarApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: PageNavigator.splash,
      onGenerateRoute: PageNavigator.onGenerateRoute,
    );
  }
}
