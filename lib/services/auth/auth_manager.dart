import 'dart:async';

import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AuthManager {
  AuthManager({@required this.auth, @required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<void> signInWithFacebook() async => await _signIn(auth.signInWithFacebook);
}