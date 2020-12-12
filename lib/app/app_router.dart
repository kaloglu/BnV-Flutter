import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, AuthService authService) {
    final args = settings.arguments;
    switch (settings.name) {
      case RaffleDetailScreen.route:
        final mapArgs = args as Map<String, dynamic>;
        final raffleId = mapArgs['raffleId'];
        return MaterialPageRoute<dynamic>(
          builder: (_) => RaffleDetailScreen(raffleId: raffleId),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}
