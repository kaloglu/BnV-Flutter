import 'dart:async';

import 'package:BedavaNeVar/model/user_model.dart';

abstract class AuthService {
  Stream<User> get onAuthStateChanged;

  void dispose();

  Future<void> saveToken(String token, {String uid = ""});

  Future<User> signInWithFacebook();

  Future<User> signInWithGoogle();

  Future<void> signOut();

  Future<void> userCreateOrUpdate(User user);
}
