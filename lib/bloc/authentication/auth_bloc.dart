import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/login_repository.dart';
import 'package:bnv/data/services/auth/firebase_auth_service.dart';
import 'package:bnv/data/services/notifications/firebase_notifications.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/widgets/common/platform_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository _repository = LoginRepository(auth: FirebaseAuthService());

  @override
  AuthenticationState get initialState => AuthInit();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is GoLoginScreen)
      yield LoginScreen();
    else if (event is GoHomeScreen)
      yield HomeScreen(event.user);
    else if (event is LoggedIn) {
      await _repository.saveToken(event.user);
      yield HomeScreen(event.user);
    } else if (event is LoggedOut) {
      await _repository.signOut();
      yield Unauthenticated();
    } else if (event is AppStarted) {
      FirebaseNotifications().setup();
      var user = await _repository.currentUser();
      bool loggedIn = false;

      loggedIn = (user != null && user.uid != null);

      if (loggedIn)
        yield Authenticated(user);
      else
        yield Unauthenticated();

      await _repository.saveToken(user);
    }
  }

  Future<User> currentUser() => _repository.currentUser();

  Future<void> signOut() async {
    await _repository.signOut();
  }

  Future<void> _showSignInError(BuildContext context, PlatformException exception) async {
    await PlatformErrorDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User user = await _repository.signInWithGoogle();
      dispatch(LoggedIn(user));
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      dispatch(LoggedOut());
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      User user = await _repository.signInWithFacebook();
      dispatch(LoggedIn(user));
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      dispatch(LoggedOut());
    }
  }
}
