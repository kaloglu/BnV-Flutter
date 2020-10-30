import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_error_dialog.dart';
import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

export 'package:firebase_auth/firebase_auth.dart' hide User;
export 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
export 'package:google_sign_in/google_sign_in.dart';

mixin AuthService {
  FirebaseAuth firebaseAuth;
  GoogleSignIn googleSignIn;
  FacebookAuth facebookSignIn;

  bool _lastLoginState = false;

  Stream<bool> get isLoggedIn$ async* {
    await for (var user in firebaseAuth.authStateChanges()) {
      var currentLoginState = user != null;

      if (_lastLoginState != currentLoginState) {
        _lastLoginState = currentLoginState;
        yield _lastLoginState;
      }
    }
  }

  Future<User> getUser() async {
    var firebaseUser = firebaseAuth.currentUser;
    //TODO: Users tablosuna kayıt atma fonksiyonu çalıştırılmalı!!! Sonrasında commentli kısım açılır.
    // return Document<User>(path: Constants.USERS, id: firebaseUser.uid).getData();
    return User.userFromFirebaseAuth(firebaseUser);
  }

  Future<void> signInWithFacebook() async {
    final LoginResult loginResult = await facebookSignIn.login();
    if (loginResult.accessToken == null)
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

    await firebaseAuth.signInWithCredential(
      FacebookAuthProvider.credential(loginResult.accessToken.token),
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    if (googleAuth == null || googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
    }

    await firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
    );
  }

  Future<void> signInWithEmail(String username, String password) {
    throw UnimplementedError();
  }

  Future<void> signInWithPhone() async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+90 544 428 79 14',
      verificationCompleted: (PhoneAuthCredential credential) async =>
          await firebaseAuth.signInWithCredential(credential),
      verificationFailed: (FirebaseAuthException e) =>
          PlatformErrorDialog(title: "Auth Error", code: e.code, message: e.message),
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = '123456';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signOutWithGoogle() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    }
  }

  Future<void> signOutWithFacebook() async {
    var fbToken = await facebookSignIn.isLogged;
    if (fbToken != null) {
      await facebookSignIn.logOut();
      await firebaseAuth.signOut();
    }
  }
}
