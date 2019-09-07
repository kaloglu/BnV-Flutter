import 'dart:async';

import 'package:bnv/model/user_model.dart';

abstract class AuthService {
  Future<User> currentUser();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> userCreateOrUpdate(User user);

  Future<void> signOut();

  Stream<String> get onAuthStateChanged;

  void dispose();

  Future<void> saveToken(String token, {String uid = ""});

}
