import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;

    // Check is already sign up
    final DocumentReference userRef = firestore.document('users/${firebaseUser.uid}');
    firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);
      if (userSnapshot.exists) {
        User user = User.fromFirestore(userSnapshot);
        await tx.update(userRef, user.toJson());
      } else {
        User user = User(
          uid: firebaseUser.uid,
          fullname: firebaseUser.displayName,
          email: firebaseUser.email,
          profilePicUrl: firebaseUser.photoUrl,
        );
        await tx.set(userRef, user.toJson());
      }
    });

    return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        fullname: firebaseUser.displayName,
        profilePicUrl: firebaseUser.photoUrl
    );
  }

  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final FirebaseUser user =
            await _firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        return _userFromFirebase(user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
      }
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
      return _userFromFirebase(user);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

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
}
