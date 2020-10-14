import 'package:BedavaNeVar/ui/screens/auth/login_screen.dart';
import 'package:BedavaNeVar/ui/screens/raffle/raffle_list_screen.dart';
import 'package:BedavaNeVar/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ScreenNavigator {
  static get defaultCanBack => true;

  // static get initialRoute => LoginScreen.route;
  static get initialRoute => LoginScreen.route;

  static goBack(context) => Navigator.pop(context);

  static navigate<T extends Object>(
    BuildContext context,
    String name, {
    bool canBack = true,
    T argument,
  }) {
    canBack = canBack ??= defaultCanBack;
    print("page: $name");
    Navigator.pushNamedAndRemoveUntil(
      context,
      name,
      (Route<dynamic> route) => canBack,
      arguments: argument,
    );
  }

  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(context, settings));

  static _buildNavigationMap(context, settings) {
    var page;
    switch (settings.name) {
      case SplashScreenScreen.route:
        page = SplashScreenScreen();
        break;
      case LoginScreen.route:
        page = LoginScreen();
        break;
      case RaffleListScreen.route:
        page = RaffleListScreen();
        break;
      // case RaffleDetailScreen.route:
      //   page = RaffleDetailScreen(viewModel: settings.arguments);
      //   break;
      default:
        throw ("Define a route case on page_navigator! \ne.g: case NewScreen.route");
    }

    return page;
  }
}
