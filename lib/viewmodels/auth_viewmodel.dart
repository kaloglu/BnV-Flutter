import 'dart:async';

import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/login_repository.dart';
import 'package:bnv/data/services/notifications/firebase_notifications.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/widgets/common/platform_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel<LoginRepository> {

  init() {
    FirebaseNotifications().setup();
  }

  Stream<User> get onAuthStateChanged => repository.onAuthStateChanged;

  Future<void> signOut() async {
    await repository.signOut();
  }

  Future<void> _showSignInError(BuildContext context, PlatformException exception) async {
    await PlatformErrorDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  FutureOr<User> signInWithGoogle(BuildContext context) async {
    try {
      return await repository.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }

    return null;
  }

  FutureOr<User> signInWithFacebook(BuildContext context) async {
    try {
      return await repository.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }

    return null;
  }
}
