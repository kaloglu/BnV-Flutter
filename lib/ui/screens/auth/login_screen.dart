import 'package:BedavaNeVar/ui/widgets/auth/login_form.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const route = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }

  static void navigate(BuildContext context) => ScreenNavigator.navigate(context, route, canBack: false);
}
