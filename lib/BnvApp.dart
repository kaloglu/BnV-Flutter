import 'package:BedavaNeVar/app/app_router.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_page.dart';
import 'package:BedavaNeVar/ui/screens/home/home_screen.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_page.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/auth/auth_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';

import 'app/top_level_providers.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends StatefulWidget {
  @override
  _BnVAppState createState() => _BnVAppState();
}

class _BnVAppState extends State<BnVApp> {
  var _themeMode;

  @override
  void initState() {
    super.initState();
    var viewModel = context.read(themeViewModel);

    setState(() {
      _themeMode = viewModel.mode;
    });

    viewModel.mode$.listen((value) {
      setState(() {
        _themeMode = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(authServiceProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      home: AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
          builder: (context, watch, _) {
            final didCompleteOnboarding = watch(onboardingViewModelProvider.state);
            return didCompleteOnboarding ? SignInPage() : OnboardingPage();
          },
        ),
        signedInBuilder: (_) => HomeScreen(),
      ),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
