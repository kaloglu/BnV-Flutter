import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: FirebaseAnalytics(),
          ),
        ],
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          ProfileScreen.route: (context) => ProfileScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          RaffleDetailScreen.route: (context) => RaffleDetailScreen(),
        },
        initialRoute: LoginScreen.route,
      );
}
