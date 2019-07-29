import 'package:bnv/model/user_model.dart';
import 'package:bnv/pages/auth/login_page.dart';
import 'package:bnv/pages/raffle/raffle_list.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/services/notifications/firebase_notifications.dart';
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
        var authService = Provider.of<AuthService>(context);
        if (snapshot.hasData) {
          authService.userCreateOrUpdate(snapshot.data);
          FirebaseNotifications.sendToken(uid: snapshot.data.uid);
          screen = RaffleListPage();
        }
        else {
          print("no Login data");
          FirebaseNotifications.sendToken();
          screen = LoginPageBuilder();
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
