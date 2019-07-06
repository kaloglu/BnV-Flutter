import 'package:bnv/firebase/BaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookAuthorization implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FacebookAuthorization() {
    //Todo...
  }

  @override
  Future<FirebaseUser> loginWithCredential(auth) async =>
      await _firebaseAuth.signInWithCredential(_getFacebookCredential(auth));

  @override
  Future<FirebaseUser> signIn() {
//    googleSignIn
//        .signIn()
//        .then((facebookSignInAuth) async =>
//    await _facebookAuthentication(facebookSignInAuth))
//        .catchError((e) => print(e));
    return _firebaseAuth.currentUser();
  }

  Future<FirebaseUser> _facebookAuthentication(facebookSignInAuth) async =>
      facebookSignInAuth.authentication
          .then((facebookAuth) async => loginWithCredential(facebookAuth))
          .catchError((e) => _firebaseAuth.currentUser());

  AuthCredential _getFacebookCredential(facebookAuth) =>
      FacebookAuthProvider.getCredential(accessToken: facebookAuth.accessToken);
}
