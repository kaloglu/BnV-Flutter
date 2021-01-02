import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/auth/auth_widget.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RaffleDetailScreen.route:
        final mapArgs = arguments as Map<String, dynamic>;
        return _buildPageRoute(RaffleDetailScreen(raffleId: mapArgs['raffleId']), settings);
      default:
        // TODO: Throw
        return null;
    }
  }
}

MaterialPageRoute _buildPageRoute(screen, settings, [shouldLogin = false, fullScreen = true]) {
  return MaterialPageRoute<dynamic>(
    builder: (_) {
      if (shouldLogin) screen = AuthWidget(signedIn: (_) => screen);
      return screen;
    },
    settings: settings,
    fullscreenDialog: fullScreen,
  );
}
