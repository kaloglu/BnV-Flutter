import 'dart:async';

import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/login_repository.dart';
import 'package:bnv/data/services/notifications/firebase_notifications.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/widgets/common/platform_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final LoginRepository _repository;
  StreamController<User> _userController = StreamController<User>();

  User _currentUser;

  User get currentUser => _currentUser;

  AuthViewModel({LoginRepository repository})
      : _repository = repository ?? LoginRepository() {
    FirebaseNotifications().setup();
//    _repository.onAuthChanged$.listen(handleAuthChanged);
  }


  @override
  void dispose() {
    _userController?.close();
    super.dispose();
  }

  Stream<User> get user => _userController.stream;

  Future<void> signOut() async {
    await _repository.signOut();
  }

  Future<void> _showSignInError(BuildContext context, PlatformException exception) async {
    await PlatformErrorDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    Future<bool> success;
    try {
      var user = await _repository.signInWithGoogle();
      _userController.add(user);
      success = Future.value(user != null && user.uid != null);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      success = Future.value(false);
    }

    return success;
  }

  Future<bool> signInWithFacebook(BuildContext context) async {
    Future<bool> success;
    try {
      var user = await _repository.signInWithFacebook();
      _userController.add(user);
      success = Future.value(user != null && user.uid != null);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
      success = Future.value(false);
    }

    return success;
  }

}
