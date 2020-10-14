import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends StatelessWidget {
  final String _route;

  BnVApp({Key key, route})
      : _route = route ?? ScreenNavigator.initialRoute,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        shadowColor: kShadowColor,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: kTitleTextColor),
          bodyText2: TextStyle(color: kBodyTextColor),
        ),
      ),
      initialRoute: _route,
      onGenerateRoute: ScreenNavigator.onGenerateRoute,
//        onGenerateRoute: ScreenNavigator.getFadeRoute,
    );
  }
}
