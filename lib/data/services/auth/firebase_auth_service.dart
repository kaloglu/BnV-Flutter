import 'package:BedavaNeVar/data/services/db/firestore_db_service.dart';
import 'package:BedavaNeVar/data/services/interfaces/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

export 'package:BedavaNeVar/data/services/interfaces/auth_service.dart';
export 'package:firebase_auth/firebase_auth.dart' hide User;

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
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges().map(User.userFromFirebaseAuth);

  @override
  void dispose() {}

  AuthCredential googleAuthCredential(GoogleSignInAuthentication googleAuth) => GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

  @override
  Future<void> saveToken(String token, {String uid = ""}) => _firestoreDB.saveToken(token, uid: uid);

  @override
  Future<User> signInWithFacebook() async {
    final FacebookLoginResult loginResult = await _facebookLogin.logIn(<String>['public_profile']);
    if (loginResult.accessToken != null) {
      final authResult =
          await _firebaseAuth.signInWithCredential(FacebookAuthProvider.credential(loginResult.accessToken.token));

      return User.userFromFirebaseAuth(authResult.user);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

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
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut(), _facebookLogin.logOut()]);
  }

  @override
  Future<void> userCreateOrUpdate(User user) => _firestoreDB.userCreateOrUpdate(user);
}
