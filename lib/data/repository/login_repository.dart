import 'dart:async';

import 'package:bnv/data/services/auth/firebase_auth_service.dart';
import 'package:bnv/data/services/interfaces/auth_service.dart';
import 'package:bnv/data/services/notifications/firebase_notifications.dart';
import 'package:bnv/model/user_model.dart';

import 'interfaces/repository.dart';

class LoginRepository implements Repository {
  final AuthService _auth;

  LoginRepository({AuthService auth}) :_auth=auth ?? FirebaseAuthService();

  Future<User> _signIn(Future<User> Function() signInMethod) async => await signInMethod();

  Future<User> signInWithGoogle() async => await _signIn(_auth.signInWithGoogle);

  Future<User> signInWithFacebook() async => await _signIn(_auth.signInWithFacebook);

  Future<User> currentUser() async => await _auth.currentUser();

  Future<void> signOut() async => _auth.signOut();

  Future<void> saveToken([User user]) async {
    final User _user = user ?? null;
    var uid = (user != null) ?_user.uid:"";
    String token = await FirebaseNotifications.getToken();
    if (token != null) {
    _auth.saveToken(token, uid: uid);
    }
  }
}