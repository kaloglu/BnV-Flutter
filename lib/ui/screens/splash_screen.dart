import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreenScreen extends StatefulWidget {
  static const route = "splash_screen";

  @override
  createState() => _SplashScreenScreenState();

  static void navigate(BuildContext context) {
    ScreenNavigator.navigate(context, route, canBack: false);
  }
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
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
