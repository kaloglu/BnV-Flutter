import 'dart:async';

import 'package:BedavaNeVar/data/repositories/login_repository.dart';
import 'package:BedavaNeVar/models/user_model.dart';

import 'base/base_viewmodel.dart';

export 'package:BedavaNeVar/models/user_model.dart';

class AuthViewModel extends BaseViewModel<LoginRepository> {
  AuthViewModel() : super(LoginRepository());

  Stream<User> get authState$ => repository.authState;

  Future<User> getUser() => repository.getUser();

  Future<void> signOut() async => await repository.signOut();

  Future<void> signInWithFacebook() async => await repository.signInWithFacebook();

  Future<void> signInWithGoogle() async => await repository.signInWithGoogle();

  Future<void> signInWithEmail(String username, String password) async =>
      await repository.signInWithEmail(username, password);
}
