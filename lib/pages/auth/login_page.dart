import 'package:bnv/firebase/auth.dart';
import 'package:bnv/widgets/loading.dart';
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
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Çekilişlerden yararlanabilmek için\ngiriş yapmalısın!',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GoogleSignInButton(
                      text: "Google ile Giriş yap",
                      onPressed: () {
                        _googleLogin();
                      },
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
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _googleLogin() async {
    await _changeLoadingVisible();
    widget.authorization.googleSignIn().then((result) async {
      if (result.uid != null) {
//        widget.onSignedIn();
      }
//      await _changeLoadingVisible();
    }).catchError(_changeLoadingVisible);
  }

}
