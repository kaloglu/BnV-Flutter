import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const signIn = '/sign-in';
  // static const editJobPage = '/edit-job-page';
  // static const entryPage = '/entry-page';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, AuthService authService) {
    final args = settings.arguments;
    switch (settings.name) {
      // case AppRoutes.signIn:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(authService, onSignedIn: args),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      //
      // case AppRoutes.editJobPage:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => EditJobPage(job: args),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      // case AppRoutes.entryPage:
      //   final mapArgs = args as Map<String, dynamic>;
      //   final job = mapArgs['job'] as Job;
      //   final entry = mapArgs['entry'] as Entry;
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => EntryPage(job: job, entry: entry),
      //     settings: settings,
      //     fullscreenDialog: true,
      //   );
      default:
        // TODO: Throw
        return null;
    }
  }
}
