import 'package:BedavaNeVar/data/services/db/firestore_db_service.dart';
import 'package:BedavaNeVar/data/services/interfaces/auth_service.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

export 'package:BedavaNeVar/data/services/interfaces/auth_service.dart';
export 'package:firebase_auth/firebase_auth.dart' hide User;

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final DBService _firestoreDB;

  FirebaseAuthService({
    firebaseAuth,
    googleSignIn,
    facebookAuth,
    DBService firestoreDB,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _firestoreDB = firestoreDB ?? FirestoreDBService();

  @override
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges().map(User.userFromFirebaseAuth);

  @override
  Future<User> signInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();
    if (loginResult.accessToken == null)
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );

    final authResult = await _firebaseAuth.signInWithCredential(
      FacebookAuthProvider.credential(loginResult.accessToken.token),
    );

    return User.userFromFirebaseAuth(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null)
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final authResult = await _firebaseAuth.signInWithCredential(
      googleAuthCredential(googleAuth),
    );
    return User.userFromFirebaseAuth(authResult.user);
  }

  @override
  Future<User> signInWithPhone() async {
    UserCredential authResult;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+90 544 428 79 14',
      verificationCompleted: (PhoneAuthCredential credential) async {
        authResult = await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        PlatformErrorDialog(
          title: "Auth Error",
          code: e.code,
          message: e.message,
        );
      },
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = '123456';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        authResult = await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return User.userFromFirebaseAuth(authResult.user);
  }

  @override
  Future<void> saveToken(String token, {String uid = ""}) => _firestoreDB.saveToken(
        token,
        uid: uid,
      );

  @override
  Future<void> userCreateOrUpdate(User user) => _firestoreDB.userCreateOrUpdate(user);

  @override
  Future<void> signOut() async => Future.wait(
        [
          _firebaseAuth.signOut(),
          _googleSignIn.signOut(),
          _facebookAuth.logOut(),
        ],
      );

  @override
  void dispose() {}

  AuthCredential googleAuthCredential(GoogleSignInAuthentication googleAuth) {
    if (googleAuth == null || googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
    }

    return GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
  }
}
