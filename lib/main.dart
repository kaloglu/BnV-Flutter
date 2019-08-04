import 'package:flutter/material.dart';

import 'bloc/authentication/bloc.dart';
import 'utils/page_navigator.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        builder: (context) => AuthenticationBloc(),
      ),
    ], child: BnVApp()),
  );
}

class BnVApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: PageNavigator.splash,
        onGenerateRoute: PageNavigator.onGenerateRoute,
//        onGenerateRoute: PageNavigator.getFadeRoute,
    );

}
