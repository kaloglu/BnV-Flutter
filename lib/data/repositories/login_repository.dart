import 'package:BedavaNeVar/data/services/auth/firebase_auth_service.dart';
import 'package:BedavaNeVar/data/services/notifications/firebase_notifications.dart';

import 'interfaces/repository.dart';

export 'package:BedavaNeVar/data/services/notifications/firebase_notifications.dart';

class LoginRepository implements Repository {
  final AuthService _auth;

  LoginRepository({AuthService auth}) : _auth = auth ?? FirebaseAuthService();

  Stream<User> get authStateChanges => _auth.stateChanges;

  Future<void> saveToken([User user]) async {
    final User _user = user ?? null;
    var uid = (user != null) ? _user.uid : "";
    String token = await FirebaseNotifications.getToken();
    if (token != null) {
      _auth.saveToken(token, uid: uid);
    }
  }

  Future<User> signInWithFacebook() async => await _signIn(_auth.signInWithFacebook);

  Future<User> signInWithGoogle() async => await _signIn(_auth.signInWithGoogle);

  Future<void> signOut() async => _auth.signOut();

  Future<User> _signIn(Future<User> Function() signInMethod) async => await signInMethod();
}
