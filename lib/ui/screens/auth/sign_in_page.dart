import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/widgets/auth/social_sign_in_widget.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignInPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [useThemeModeSwitch(context)],
        elevation: 2.0,
        title: Text("title"),
      ),
      backgroundColor: Colors.grey[200],
      body: SocialSignIn(),
    );
  }
}
