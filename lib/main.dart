import 'package:bloc/bloc.dart';
import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/bloc/delegation/simple_bloc_delegation.dart';
import 'package:bnv/services/notifications/firebase_notifications.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/raffle_list/bloc.dart';

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
  Widget build(BuildContext context) {
    FirebaseNotifications().setup();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: PageNavigator.splash,
        onGenerateRoute: PageNavigator.onGenerateRoute,
    );
  }
}
