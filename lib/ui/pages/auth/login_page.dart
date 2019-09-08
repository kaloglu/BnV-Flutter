import 'package:bnv/ui/widgets/login_form.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const route = "login";
  static void navigate(BuildContext context) => PageNavigator.navigate(context, route, canBack: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }

}
