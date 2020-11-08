import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class SplashScreenScreen extends StatefulWidget {
  static const route = "/";

  @override
  createState() => _SplashScreenScreenState();

  static navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushReplacementNamed(context, route);
  }
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  AuthViewModel viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: StreamBuilder(
          stream: viewModel.authState$,
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                Future.delayed(Duration.zero, () {
                  if (snapshot.hasData && (snapshot.data as User).uid != null) {
                    return HomeScreen.navigate(context);
                  }

                  return LoginScreen.navigate(context);
                });
                return Container();
              default:
                return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("dispose splash!");
    super.dispose();
  }
}
