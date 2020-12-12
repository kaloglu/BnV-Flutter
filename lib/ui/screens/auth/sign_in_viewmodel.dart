import 'dart:async';

import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(auth: ref.watch(authServiceProvider)),
);

class SignInViewModel with ChangeNotifier {
  SignInViewModel({@required this.auth});

  final AuthService auth;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(Future<void> Function() signInMethod) async {
    try {
      isLoading = true;
      notifyListeners();
      await signInMethod();
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<void> signInFacebook() async {
    await _signIn(auth.signInWithFacebook);
  }

  Future<void> signOut() async {
    auth.signOutWithGoogle();
    auth.signOutWithFacebook();
  }
}
