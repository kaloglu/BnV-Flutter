import 'dart:async';

import 'package:bnv/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  GoogleSignIn googleauth;
  FirebaseAuth firebaseAuth;

  AuthStatus authStatus;

  Future<FirebaseUser> loginWithCredential(credential);

  AuthCredential getGoogleCredential(googleAuth);

  Future<FirebaseUser> googleAuthentication(googleAuth);

  void googleSignIn();

}

class Auth implements BaseAuth {

  @override
  GoogleSignIn googleauth = new GoogleSignIn();

  @override
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  AuthStatus authStatus = AuthStatus.notSignedIn;


  @override
  Future<FirebaseUser> loginWithCredential(credential) async =>
      await firebaseAuth.signInWithCredential(credential);

  @override
  AuthCredential getGoogleCredential(googleAuth) =>
      GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

  @override
  Future<FirebaseUser> googleAuthentication(googleSignInAuth) async =>
      googleSignInAuth.authentication
          .then((googleAuth) async => firebaseAuth
              .signInWithCredential(getGoogleCredential(googleAuth)))
          .catchError((e) => firebaseAuth.currentUser());

  @override
  void googleSignIn() {
    googleauth
        .signIn()
        .then((googleSignInAuth) async =>
            await googleAuthentication(googleSignInAuth))
        .catchError((e) => print(e));
  }

}
