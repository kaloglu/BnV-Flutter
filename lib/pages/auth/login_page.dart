import 'package:bnv/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;

  LoginPage({Key key, this.auth}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  loginWithGoogle() {
    widget.auth.googleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Çekilişlerden yararlanabilmek için\ngiriş yapmalısın.',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GoogleSignInButton(
                    text:"Google ile Giriş yap",
                    onPressed: () {},
                    darkMode: true,
                    borderRadius: 10,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),),
                  FacebookSignInButton(
                    text: "Yakında...",
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
