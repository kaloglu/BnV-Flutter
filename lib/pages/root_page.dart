import 'package:bnv/enums.dart';
import 'package:bnv/firebase/auth.dart';
import 'package:bnv/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;

  RootPage({this.auth});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    switch (widget.auth.authStatus) {
      case AuthStatus.signedIn:
        return Container(
          child: new Text("loggedIn"),
        );
      default: //case AuthStatus.notSigndIn:
        return LoginPage(auth: widget.auth);
    }
  }
}
