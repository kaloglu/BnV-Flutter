import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/widgets/auth/social_sign_in_widget.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeModeSwitch()],
        elevation: 2.0,
        title: Text("title"),
      ),
      backgroundColor: Colors.grey[200],
      body: SocialSignIn(),
    );
  }
}
