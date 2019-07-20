import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/db/firestore_service_adapter.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DBServiceAdapter _firestoreDB = DBServiceAdapter();

  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(User.userFromFirebaseAuth);

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null)
        return User.userFromFirebaseAuth(await _firebaseAuth.signInWithCredential(googleAuthCredential(googleAuth)));

      //else
      throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(<String>['public_profile']);
    if (result.accessToken != null) {
      final FirebaseUser user = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(accessToken: result.accessToken.token),
      );
      return User.userFromFirebaseAuth(user);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async => User.userFromFirebaseAuth(await _firebaseAuth.currentUser());

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}

  AuthCredential googleAuthCredential(GoogleSignInAuthentication googleAuth) =>
      GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

  @override
  Future<void> userCreateOrUpdate(User user) => _firestoreDB.userCreateOrUpdate(user);
}
