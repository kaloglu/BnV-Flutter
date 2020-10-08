import 'package:BedavaNeVar/data/repository/login_repository.dart';

import 'base/base_viewmodel.dart';

class AuthViewModel extends BaseViewModel<LoginRepository> {
  // Stream<User> get onAuthStateChanged => repository.onAuthStateChanged;

  init() {
    // FirebaseNotifications().setup();
  }

/*FutureOr<User> signInWithFacebook(BuildContext context) async {
    try {
      return await repository.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }

    return null;
  }

  FutureOr<User> signInWithGoogle(BuildContext context) async {
    try {
      return await repository.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }

    return null;
  }

  Future<void> signOut() async {
    await repository.signOut();
  }

  Future<void> _showSignInError(BuildContext context, PlatformException exception) async {
    await PlatformErrorDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }*/
}
