import 'dart:async';

import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/auth/firebase_auth_service.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:flutter/foundation.dart';

enum AuthServiceType { firebase }

class AuthServiceAdapter implements AuthService {
  AuthServiceAdapter() {
    _setup();
  }

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  ValueNotifier<AuthServiceType> authServiceTypeNotifier = ValueNotifier<AuthServiceType>(AuthServiceType.firebase);

  AuthServiceType get authServiceType => authServiceTypeNotifier.value;

  AuthService get authService => authServiceType == AuthServiceType.firebase ? _firebaseAuthService : null;

  StreamSubscription<User> _firebaseAuthSubscription;

  void _setup() {
    // Observable<User>.merge was considered here, but we need more fine grained control to ensure
    // that only events from the currently active service are processed
    _firebaseAuthSubscription = _firebaseAuthService.onAuthStateChanged.listen((User user) {
      if (authServiceType == AuthServiceType.firebase) {
        _onAuthStateChangedController.add(user);
      }
    }, onError: (dynamic error) {
      if (authServiceType == AuthServiceType.firebase) {
        _onAuthStateChangedController.addError(error);
      }
    });
  }

  @override
  void dispose() {
    _firebaseAuthSubscription?.cancel();
    _onAuthStateChangedController?.close();
  }

  final StreamController<User> _onAuthStateChangedController = StreamController<User>();

  @override
  Stream<User> get onAuthStateChanged => _onAuthStateChangedController.stream;

  @override
  Future<User> currentUser() => authService.currentUser();

  @override
  Future<void> userCreateOrUpdate(User user) => authService.userCreateOrUpdate(user);

  @override
  Future<User> signInWithFacebook() => authService.signInWithFacebook();

  @override
  Future<User> signInWithGoogle() => authService.signInWithGoogle();

  @override
  Future<void> signOut() => authService.signOut();

}
