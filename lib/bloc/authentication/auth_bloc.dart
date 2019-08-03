import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/login_repository.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/auth/auth_service_adapter.dart';
import 'package:bnv/ui/widget/common/platform_error_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository _repository = LoginRepository(auth: AuthServiceAdapter());

  @override
  AuthenticationState get initialState => AuthInit();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is LoggedOut) {
      _repository.signOut();
      yield Unauthenticated();
    } else {
      var user = await _repository.currentUser();
      bool loggedIn = false;

      loggedIn = ((event is AppStarted) && (user != null && user.uid != null)) || (event is LoggedIn);

      if (loggedIn)
        yield Authenticated(user);
      else
        yield Unauthenticated();

      await _repository.saveToken();
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
      await _repository.signInWithGoogle();
      dispatch(LoggedIn());
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      dispatch(LoggedOut());
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      await _repository.signInWithFacebook();
      dispatch(LoggedIn());
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      dispatch(LoggedOut());
    }
  }
}
