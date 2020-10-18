import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginForm extends StatelessWidget {
  final AuthViewModel viewModel;

  const LoginForm({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              child: Column(
                children: <Widget>[
                  Text(
                    Strings.BnV,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Text(
                    Strings.signIn,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.0),
            GoogleSignInButton(
              text: Strings.signInWithGoogle,
              onPressed: () async => await viewModel.signInWithGoogle(),
              darkMode: true,
              borderRadius: 10,
            ),
            SizedBox(height: 8),
            // FacebookSignInButton(
            //   text: Strings.signInWithFacebook,
            //   onPressed: () async => await viewModel.signInWithFacebook(),
            //   borderRadius: 10,
            // ),
            // SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
