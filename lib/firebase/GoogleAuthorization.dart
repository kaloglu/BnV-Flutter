import 'dart:async';

import 'package:bnv/firebase/BaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthorization implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn;

  GoogleAuthorization() {
    this._googleSignIn = new GoogleSignIn();
  }

  @override
  Future<FirebaseUser> signIn() {
    if (_googleSignIn.currentUser == null) {
      return _googleSignIn.signIn().then(signedIn).catchError(gsaError);
    } else {
      return _googleSignIn.signInSilently().then(signedIn).catchError(gsaError);
    }
  }

  @override
  Future<FirebaseUser> loginWithCredential(auth) async =>
      await _firebaseAuth.signInWithCredential(_getGoogleCredential(auth));

  Future<FirebaseUser> _googleAuthentication(googleSignInAuth) async =>
      googleSignInAuth.authentication
          .then((googleAuth) async => loginWithCredential(googleAuth))
          .catchError(gsaError);

  AuthCredential _getGoogleCredential(googleAuth) =>
      GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

  FutureOr<FirebaseUser> signedIn(GoogleSignInAccount gsa) async =>
      await _googleAuthentication(gsa);

  gsaError(e) => _firebaseAuth.currentUser();
}
