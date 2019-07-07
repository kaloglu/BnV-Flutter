import 'package:bnv/firebase/auth.dart';
import 'package:bnv/pages/root_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future main() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Authorization _authorization = new Authorization();

//  _firebaseMessaging.requestNotificationPermissions(
//      const IosNotificationSettings(sound: true, badge: true, alert: true));
//  _firebaseMessaging.onIosSettingsRegistered
//      .listen((IosNotificationSettings settings) {
//    print("Settings registered: $settings");
//  });
//  _firebaseMessaging.getToken().then((String token) {
//    assert(token != null);
//    setDeviceToken(token);
//    print("getToken $token");
//  });
//
//  _firebaseMessaging.onTokenRefresh.listen((String token) {
//    assert(token != null);
//    setDeviceToken(token);
//  });

  runApp(BedavaNeVarApp(
      firebaseMessaging: _firebaseMessaging, authorization: _authorization));
}

class BedavaNeVarApp extends StatelessWidget {
  final FirebaseMessaging firebaseMessaging;
  final Authorization authorization;

  BedavaNeVarApp({this.firebaseMessaging, this.authorization});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RootPage(authorization: authorization),
    );
  }
}
