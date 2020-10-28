import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/enums.dart';
import 'package:BedavaNeVar/data/repositories/interfaces/repository.dart';
import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';

class LoginRepository with AuthService implements Repository {
  @override
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  final FacebookAuth facebookSignIn = FacebookAuth.instance;

  LoginRepository();

  Stream<List<Raffle>> getRaffles() {
    return Collection<Raffle>(path: Constants.RAFFLES).streamData();
  }

  Future<void> signIn(SignInType signInType, [String username, String password]) async {
    switch (signInType) {
      case SignInType.GOOGLE:
        signInWithGoogle();
        break;
      case SignInType.FACEBOOK:
        signInWithFacebook();
        break;
      case SignInType.USERNAME:
        signInWithEmail(username, password);
        break;
      default:
        break;
    }
  }

  Future<void> signOut() async {
    await signOutWithGoogle();
    await signOutWithFacebook();
  }
}
