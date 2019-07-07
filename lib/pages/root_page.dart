import 'package:bnv/enums.dart';
import 'package:bnv/firebase/auth.dart';
import 'package:bnv/pages/auth/login_page.dart';
import 'package:bnv/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  final Authorization authorization;

  RootPage({this.authorization});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String _username="";
  String _token="";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user){
      setState(() {
        assert(user != null);
        _username = user.displayName;
        widget.authorization.authStatus =
        (user.displayName == null) ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.authorization.authStatus) {
      case AuthStatus.signedIn:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("$_username $_token"),
                RaisedButton(
                    child: Text("Sign Out"),
                    onPressed: () =>
                        widget.authorization.signOut().then((onValue) {
                          setState(() {
                            widget.authorization.authStatus = AuthStatus.notSignedIn;
                          });
                        }))
              ],
            ),
          ),
        );
      default: //case AuthStatus.notSigndIn:
        return LoginPage(
          authorization: widget.authorization,
          onSignedIn: () {
            setState(() {
              widget.authorization.authStatus = AuthStatus.signedIn;
            });
          },);
    }
  }
}
