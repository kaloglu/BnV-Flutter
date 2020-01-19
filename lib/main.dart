import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider_setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: providers,
      child: BnVApp(),
    ),
  );
}

class BnVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: PageNavigator.initialRoute,
        onGenerateRoute: PageNavigator.onGenerateRoute,
//        onGenerateRoute: PageNavigator.getFadeRoute,
      );
}
