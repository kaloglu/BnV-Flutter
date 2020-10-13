import 'package:BedavaNeVar/models/user_model.dart';

export 'package:BedavaNeVar/models/user_model.dart';

abstract class AuthService {
  Stream<User> get stateChanges;

  void dispose();

  Future<void> saveToken(String token, {String uid = ""});

  Future<User> signInWithFacebook();

  Future<User> signInWithGoogle();

  Future<void> signOut();

  Future<void> userCreateOrUpdate(User user);
}
