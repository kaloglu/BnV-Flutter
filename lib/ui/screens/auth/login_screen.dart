import 'package:BedavaNeVar/ui/widgets/auth/login_form.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();

  static navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<User>(
            stream: viewModel.authState$,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    return LoginForm(viewModel: viewModel);
                  } else {
                    return Container();
                  }
                  break;
                default:
                  return Text("login-screen default");
              }
            }),
      ),
    );
  }
}
