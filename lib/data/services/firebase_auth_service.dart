import 'package:BedavaNeVar/models/user_model.dart' as UserModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookSignIn = FacebookAuth.instance;

  bool _lastLoginState;

  // Stream<User> get authState => _auth.authStateChanges();
  Stream<UserModel.User> get authState async* {
    await for (var user in _auth.authStateChanges()) {
      var currentLoginState = user != null;

      if (_lastLoginState != currentLoginState) {
        _lastLoginState = currentLoginState;
        yield UserModel.User.userFromFirebaseAuth(user);
      }
    }
  }

  UserModel.User getUser() {
    var firebaseUser = _auth.currentUser;
    //TODO: Users tablosuna kayıt atma fonksiyonu çalıştırılmalı!!! Sonrasında commentli kısım açılır.
    // return Document<User>(path: Constants.USERS, id: firebaseUser.uid).getData();
    return UserModel.User.userFromFirebaseAuth(firebaseUser);
  }

  Future<void> signInWithFacebook() async {
    final AccessToken loginResult = await _facebookSignIn.login();
    if (loginResult.token == null)
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

    await _auth.signInWithCredential(
      FacebookAuthProvider.credential(loginResult.token),
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    if (googleAuth == null || googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
    }

    await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
    );
  }

  Future<void> signInWithEmail(String username, String password) {
    throw UnimplementedError();
  }

  // Future<void> signInWithPhone() async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: '+90 544 428 79 14',
  //     verificationCompleted: (PhoneAuthCredential credential) async => await _auth.signInWithCredential(credential),
  //     verificationFailed: (FirebaseAuthException e) =>
  //         PlatformErrorDialog(title: "Auth Error", code: e.code, message: e.message),
  //     codeSent: (String verificationId, int resendToken) async {
  //       // Update the UI - wait for the user to enter the SMS code
  //       String smsCode = '123456';
  //
  //       // Create a PhoneAuthCredential with the code
  //       PhoneAuthCredential phoneAuthCredential =
  //           PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //
  //       // Sign the user in (or link) with the credential
  //       await _auth.signInWithCredential(phoneAuthCredential);
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }

  Future<void> signOutWithGoogle() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
      await _auth.signOut();
    }
  }

  Future<void> signOutWithFacebook() async {
    var fbToken = await _facebookSignIn.isLogged;
    if (fbToken != null) {
      await _facebookSignIn.logOut();
      await _auth.signOut();
    }
  }
}
