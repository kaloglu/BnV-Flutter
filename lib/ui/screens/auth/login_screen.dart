import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:BedavaNeVar/ui/widgets/auth/login_form.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/login";

  LoginScreen({Key key}) : super(key: key);

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
  void initState() {
    super.initState();
    viewModel.isLoggedIn$.listen((loggedIn) {
      if (loggedIn) {
        HomeScreen.navigate(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<bool>(
            stream: viewModel.isLoggedIn$,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                case ConnectionState.active:
                  if (!snapshot.hasData && !snapshot.data) {
                    return LoginForm(viewModel: viewModel);
                  } else {
                    return Container();
                  }
                  break;
                default:
                  return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
