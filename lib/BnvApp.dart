import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/login_screen.dart';
import 'package:BedavaNeVar/ui/screens/home_screen.dart';
import 'package:BedavaNeVar/ui/screens/profile/profile_screen.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends StatefulWidget {
  @override
  _BnVAppState createState() => _BnVAppState();
}

class _BnVAppState extends State<BnVApp> {
  bool _useLightTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _useLightTheme ? lightTheme : darkTheme,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        ProfileScreen.route: (context) => ProfileScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        RaffleDetailScreen.route: (context) => RaffleDetailScreen(),
        SplashScreenScreen.route: (context) => SplashScreenScreen(),
      },
    );
  }
}
