import 'package:bnv/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  final Authorization authorization;
  final VoidCallback onSignedIn;

  LoginPage({Key key, this.authorization, this.onSignedIn}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Çekilişlerden yararlanabilmek için\ngiriş yapmalısın!',
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
                    onPressed: () =>
                        widget.authorization.googleSignIn().then((result) {
                          if (result.uid != null)
                            widget.onSignedIn();
                        }),
                    darkMode: true,
                    borderRadius: 10,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),),
                  FacebookSignInButton(
                    text: "Yakında...",
                    borderRadius: 10,
//                    onPressed: () => widget.authorization.googleSignIn(),
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
