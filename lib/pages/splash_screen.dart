import 'package:bnv/model/user_model.dart';
import 'package:bnv/pages/auth/login_page.dart';
import 'package:bnv/pages/raffle/raffle_list.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: _splashScreenBuilder,
    );
  }

  Widget _splashScreenBuilder(BuildContext context, AsyncSnapshot<User> snapshot) {
    var screen;
    if (snapshot.connectionState == ConnectionState.active) {
      if (snapshot.data == null)
        screen = LoginPageBuilder();
      else {
        var authService = Provider.of<AuthService>(context);
        authService.userCreateOrUpdate(snapshot.data);
        screen = RaffleListPage();
      }
    } else
      screen = SplashScreenWidget();

    return screen;
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      new Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "BedavaNeVar",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
}
