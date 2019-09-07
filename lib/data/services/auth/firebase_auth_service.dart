import 'package:bnv/data/services/db/firestore_db_service.dart';
import 'package:bnv/data/services/interfaces/auth_service.dart';
import 'package:bnv/data/services/interfaces/db_service.dart';
import 'package:bnv/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final DBService _firestoreDB;

  FirebaseAuthService({firebaseAuth, googleSignIn, facebookLogin, DBService firestoreDB})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _firestoreDB = firestoreDB ?? FirestoreDBService();

  @override
  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map((user) => (user == null || user.uid == null) ? "" : user.uid);

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(googleAuthCredential(googleAuth));
        return User.userFromFirebaseAuth(authResult.user);
      } else
        throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final FacebookLoginResult loginResult = await _facebookLogin.logInWithReadPermissions(<String>['public_profile']);
    if (loginResult.accessToken != null) {
      final authResult = await _firebaseAuth
          .signInWithCredential(FacebookAuthProvider.getCredential(accessToken: loginResult.accessToken.token));

      return User.userFromFirebaseAuth(authResult.user);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser == null) return null;

    return await _firestoreDB.getLoggedInUser(firebaseUser.uid);
  }

  @override
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut(), _facebookLogin.logOut()]);
  }

  @override
  void dispose() {}

  AuthCredential googleAuthCredential(GoogleSignInAuthentication googleAuth) => GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

  @override
  Future<void> userCreateOrUpdate(User user) => _firestoreDB.userCreateOrUpdate(user);

  @override
  Future<void> saveToken(String token, {String uid = ""}) => _firestoreDB.saveToken(token, uid: uid);
}
