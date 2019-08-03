import 'dart:async';

import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/auth/firebase_auth_service.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/services/notifications/firebase_notifications.dart';

class LoginRepository {
  final AuthService _auth;

  LoginRepository({AuthService auth}) :_auth=auth ?? FirebaseAuthService();

  Future<User> _signIn(Future<User> Function() signInMethod) async => await signInMethod();

  Future<void> signInWithGoogle() async => await _signIn(_auth.signInWithGoogle);

  Future<void> signInWithFacebook() async => await _signIn(_auth.signInWithFacebook);

  Future<User> currentUser() async => await _auth.currentUser();

  Future<void> signOut() async => _auth.signOut();

  Future<void> saveToken() async {
    User user = await _auth.currentUser();
    String token = await FirebaseNotifications.getToken();
    if (token != null) {
      _auth.saveToken(token, uid: user.uid);
    }
  }
}