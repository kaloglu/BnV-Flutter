import 'package:bnv/model/user_model.dart';
import 'package:bnv/pages/auth/login_page.dart';
import 'package:bnv/pages/raffle/raffle_list.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (_, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active)
          return snapshot.data == null ? LoginPageBuilder() : RaffleListPage();
        else
          return
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
      },
    );
  }
}
