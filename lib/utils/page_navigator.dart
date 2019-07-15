import 'package:bnv/pages/auth/login_page.dart';
import 'package:bnv/pages/raffle/raffle_detail.dart';
import 'package:bnv/pages/raffle/raffle_list.dart';
import 'package:bnv/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  static const String splash = "splash";
  static const String login = "login";
  static const String raffleList = "raffleList";
  static const String raffleDetail = "raffleDetail";

  static get defaultCanBack => true;

  static _goPage(context, String pageName, [bool canBack]) {
    Navigator.pushNamedAndRemoveUntil(context, pageName,
        (Route<dynamic> route) => canBack ??= defaultCanBack);
  }

  static goRaffleList(context, [bool canBack]) =>
      _goPage(context, raffleList, canBack);

  static goRaffleDetail(context, [bool canBack]) =>
      _goPage(context, raffleDetail, canBack);

  static goLogin(context, [bool canBack]) => _goPage(context, login, canBack);

  static goSplash(context) => _goPage(context, splash, false);

  static goBack(context) => Navigator.pop(context);

  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(settings));

  static _buildNavigationMap(settings) {
    var page;
    switch (settings.name) {
      case splash:
        page = SplashScreenPage();
        break;
      case login:
        page = LoginPageBuilder();
        break;
      case raffleList:
        page = RaffleListPage(arguments: settings.arguments);
        break;
      case raffleDetail:
        page = RaffleDetailPage(arguments: settings.arguments);
        break;
    }
    return page;
  }

}
