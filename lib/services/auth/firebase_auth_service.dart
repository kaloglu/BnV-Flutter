import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/db/firestore_service_adapter.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  final DBServiceAdapter _firestoreDB = DBServiceAdapter();

  FirebaseAuthService({firebaseAuth, googleSignIn, facebookLogin})
      :
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(User.userFromFirebaseAuth);

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        var firebaseUser = await _firebaseAuth.signInWithCredential(googleAuthCredential(googleAuth));
        return User.userFromFirebaseAuth(firebaseUser);
      } else
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token'
        );
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final FacebookLoginResult result =
    await _facebookLogin.logInWithReadPermissions(<String>['public_profile']);
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
  Future<User> currentUser() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser==null)
      return null;
    Stream<User> userStream = _firestoreDB.getUser(firebaseUser.uid);
    await for (User value in userStream) {
      return value;
    }
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      _facebookLogin.logOut()
    ]);
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

  @override
  Future<void> saveToken(String token, { String uid}) => _firestoreDB.saveToken(token, uid: uid);


}
