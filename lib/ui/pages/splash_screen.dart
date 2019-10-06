import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  static const route = "splash_screen";

  @override
  createState() => _SplashScreenPageState();

  static void navigate(BuildContext context) {
    PageNavigator.navigate(context, route, canBack: false);
  }
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "BedavaNeVar",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("dispose splash!");
    super.dispose();
  }
}
