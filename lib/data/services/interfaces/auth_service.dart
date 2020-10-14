import 'package:BedavaNeVar/models/user_model.dart';

export 'package:BedavaNeVar/models/user_model.dart';

abstract class AuthService {
  Stream<User> get stateChanges;

  Future<User> signInWithFacebook();

  Future<User> signInWithGoogle();

  Future<User> signInWithPhone();

  Future<void> saveToken(String token, {String uid = ""});

  Future<void> signOut();

  Future<void> userCreateOrUpdate(User user);

  void dispose();
}
