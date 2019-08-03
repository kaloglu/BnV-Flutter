import 'package:flutter/material.dart';

import 'bloc/authentication/bloc.dart';
import 'bloc/raffle_list/raffle_list_bloc.dart';
import 'utils/page_navigator.dart';

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        builder: (context) => AuthenticationBloc(),
      ),
      BlocProvider<RaffleListBloc>(
        builder: (context) => RaffleListBloc(),
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
    );
}
