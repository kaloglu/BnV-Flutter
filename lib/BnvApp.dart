import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: FirebaseAnalytics(),
          ),
        ],
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.shifting,
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.black26,
              showSelectedLabels: false,
              showUnselectedLabels: true),
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          shadowColor: kShadowColor,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: kTitleTextColor),
            bodyText2: TextStyle(color: kBodyTextColor),
          ),
        ),
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          RaffleDetailScreen.route: (context) => RaffleDetailScreen(),
        },
        initialRoute: HomeScreen.route,
      );
}
