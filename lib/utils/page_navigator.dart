import 'package:bnv/ui/pages/auth/login_page.dart';
import 'package:bnv/ui/pages/raffle/detail/raffle_detail_page.dart';
import 'package:bnv/ui/pages/raffle/raffle_list_page.dart';
import 'package:bnv/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  static const String splash = "splash";
  static const String login = "login";
  static const String raffleList = "raffleList";
  static const String raffleDetail = "raffleDetail";

  static get defaultCanBack => true;

  static _goPage(context, String pageName, {bool canBack = true, Object arguments}) {
    canBack = canBack ??= defaultCanBack;
    Navigator.pushNamedAndRemoveUntil(context, pageName,
            (Route<dynamic> route) => canBack, arguments: arguments);
  }

  static goRaffleList(context, {bool canBack = true}) =>
      _goPage(context, raffleList, canBack: canBack);

  static goRaffleDetail(context, raffle, {bool canBack = true}) =>
      _goPage(context, raffleDetail, canBack: canBack, arguments: raffle);

  static goLogin(context, {bool canBack = true}) => _goPage(context, login, canBack: canBack);

  static goSplash(context) => _goPage(context, splash, canBack: false);

  static goBack(context) => Navigator.pop(context);

  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(context, settings));

  static _buildNavigationMap(context, settings) {
    var page;
    switch (settings.name) {
      case splash:
        page = SplashScreenWidget();
        break;
      case login:
        page = LoginPage();
        break;
      case raffleList:
        page = RaffleListPage(arguments: settings.arguments);
        break;
      case raffleDetail:
        page = RaffleDetailPage(raffle: settings.arguments);
//        page = PokemonInfo();
        break;
    }
    return page;
  }

}
