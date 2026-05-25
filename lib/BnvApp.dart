import 'package:BedavaNeVar/app/app_router.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/home/home_screen.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_page.dart';
import 'package:BedavaNeVar/ui/widgets/onboarding/onboarding_widget.dart';
import 'package:BedavaNeVar/ui/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

export 'package:BedavaNeVar/constants/constants.dart';

class BnVApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting('tr');
    final themeMode = ref.watch(themeViewModelProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: OnboardingWidget(
        onBoarding: (_) => OnboardingPage(),
        afterOrSkip: (_) => HomeScreen(),
      ),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
