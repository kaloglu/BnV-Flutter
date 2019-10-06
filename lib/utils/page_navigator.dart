import 'package:bnv/ui/pages/auth/login_page.dart';
import 'package:bnv/ui/pages/raffle/detail/raffle_detail_page.dart';
import 'package:bnv/ui/pages/raffle/raffle_list_page.dart';
import 'package:bnv/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  static get defaultCanBack => true;

  static get initialRoute => LoginPage.route;

  static goBack(context) => Navigator.pop(context);

  static navigate<T extends Object>(BuildContext context, String name, {bool canBack = true, T argument}) {
    canBack = canBack ??= defaultCanBack;
    print("page: $name");
    Navigator.pushNamedAndRemoveUntil(context, name, (Route<dynamic> route) => canBack, arguments: argument);
  }

  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(context, settings));

  static _buildNavigationMap(context, settings) {
    var page;
    switch (settings.name) {
      case SplashScreenPage.route:
        page = SplashScreenPage();
        break;
      case LoginPage.route:
        page = LoginPage();
        break;
      case RaffleListPage.route:
        page = RaffleListPage();
        break;
      case RaffleDetailPage.route:
        page = RaffleDetailPage(viewModel: settings.arguments);
        break;
    }

    return page;
  }
}
