import 'dart:async';

import 'package:bnv/utils/page_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  final Object arguments;

  SplashScreenPage({Key key, this.arguments}) : super(key: key);

  @override
  _SplashScreenPageState createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser().then((firebaseUser) {
        //never can Pop
        if (firebaseUser == null || firebaseUser.uid == null) {
          PageNavigator.goLogin(context, false);
        } else
          PageNavigator.goRaffleList(context, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        body: Center(
            child: Text(
          "BedavaNeVar",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )),
      );
}
