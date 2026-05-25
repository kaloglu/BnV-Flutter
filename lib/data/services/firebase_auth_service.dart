import 'package:BedavaNeVar/models/user/user.dart' as UserModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool loginState = false;

  get auth => _auth;

  // Stream<User> get authState => _auth.authStateChanges();
  Stream<UserModel.User> get authState async* {
    await for (var user in _auth.authStateChanges()) {
      var currentLoginState = user != null;

      if (loginState != currentLoginState) {
        loginState = currentLoginState;
        yield UserModel.User.userFromSocialAuth(user);
      }
    }
  }

  UserModel.User getUser() {
    var firebaseUser = _auth.currentUser;
    return UserModel.User.userFromSocialAuth(firebaseUser);
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Kullanıcı işlemi iptal etti');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Google Auth Token eksik');
    }

    await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
    );
  }

  Future<void> signInWithEmail(String username, String password) {
    throw UnimplementedError();
  }

  Future<void> signOutWithGoogle() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
      await _auth.signOut();
    }
  }
}
