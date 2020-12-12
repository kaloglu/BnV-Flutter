import 'package:BedavaNeVar/app/app_router.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_page.dart';
import 'package:BedavaNeVar/ui/screens/home/home_screen.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_page.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/auth/auth_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/top_level_providers.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    final firebaseAuth = useProvider(authServiceProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: useThemeListener().value,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      home: AuthWidget(
        onBoarding: (_) => OnboardingPage(),
        nonSignedIn: (_) => SignInPage(),
        signedIn: (_) => HomeScreen(),
      ),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
