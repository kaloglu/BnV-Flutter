import 'dart:async';

import 'package:bnv/enums.dart';
import 'package:bnv/firebase/FacebookAuthorization.dart';
import 'package:bnv/firebase/GoogleAuthorization.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class Authorization {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  GoogleAuthorization _googleAuthorization = new GoogleAuthorization();
  FacebookAuthorization _facebookAuthorization = new FacebookAuthorization();

  Future<FirebaseUser> googleSignIn() => _googleAuthorization.signIn();

  Future<FirebaseUser> facebookSignIn() => _facebookAuthorization.signIn();

  Future<void> signOut() async => await _firebaseAuth.signOut().whenComplete((){
    _googleAuthorization.signOut();
    _facebookAuthorization.signOut();
  });

  Future<FirebaseUser> currentUser() async =>
      await FirebaseAuth.instance.currentUser();
}
