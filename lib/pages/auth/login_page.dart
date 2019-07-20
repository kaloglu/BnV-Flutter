import 'package:bnv/common_widgets/platform_error_dialog.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/services/auth/auth_manager.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

//class LoginPage extends StatefulWidget {
//  final Object arguments;
//  final Authorization authorization;
//  final VoidCallback onSignedIn;
//
//  LoginPage({Key key, this.arguments, this.authorization, this.onSignedIn})
//      : super(key: key);
//
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  bool _loadingVisible = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Çekilişlerden yararlanabilmek için\ngiriş yapmalısın!',
//              style: TextStyle(fontWeight: FontWeight.bold),
//              textAlign: TextAlign.center,
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(
//                  horizontal: 40.0, vertical: 20),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  GoogleSignInButton(
//                    text: "Google ile Giriş yap",
//                    onPressed: () {
//                      Authorization().googleSignIn().then((result) {
//                        if (result != null && result.uid != null)
//                          PageNavigator.goRaffleList(context, false);
//                      });
//                    },
//                    darkMode: true,
//                    borderRadius: 10,
//                  ),
//                  Padding(padding: EdgeInsets.symmetric(vertical: 10),),
//                  FacebookSignInButton(
//                    text: "Yakında...",
//                    borderRadius: 10,
////                    onPressed: () => widget.authorization.googleSignIn(),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Future<void> _changeLoadingVisible() async {
//    setState(() {
//      _loadingVisible = !_loadingVisible;
//    });
//  }
//
//  void _googleLogin() async {
//    await _changeLoadingVisible();
//    widget.authorization.googleSignIn().then((result) async {
//      if (result.uid != null) {
////        widget.onSignedIn();
//      }
////      await _changeLoadingVisible();
//    }).catchError(_changeLoadingVisible);
//  }
//
//}

class LoginPageBuilder extends StatelessWidget {
  // P<ValueNotifier>
  //   P<AuthManager>(valueNotifier)
  //     LoginPage(value)
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      builder: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<AuthManager>(
              builder: (_) => AuthManager(auth: auth, isLoading: isLoading),
              child: Consumer<AuthManager>(
                builder: (_, AuthManager manager, __) =>
                    LoginPage._(
                      isLoading: isLoading.value,
                      manager: manager,
                    ),
              ),
            ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage._({Key key, this.isLoading, this.manager}) : super(key: key);
  final AuthManager manager;
  final bool isLoading;

  Future<void> _showSignInError(BuildContext context, PlatformException exception) async {
    await PlatformErrorDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();

    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hide developer menu while loading in progress.
      // This is so that it's not possible to switch auth service while a request is in progress
//      drawer: isLoading ? null : DeveloperMenu(),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 48.0),
          GoogleSignInButton(
            text: Strings.signInWithGoogle,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
            darkMode: true,
            borderRadius: 10,
          ),
          SizedBox(height: 8),
          FacebookSignInButton(
            text: Strings.signInWithFacebook,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
            borderRadius: 10,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}