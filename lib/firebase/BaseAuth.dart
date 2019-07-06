import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> loginWithCredential(credential);

  Future<FirebaseUser> signIn();
}
