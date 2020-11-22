import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/screens/onboarding/onboarding_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class AuthWidget extends HookWidget {
  const AuthWidget({
    Key key,
    this.onBoarding,
    @required this.signedIn,
    @required this.nonSignedIn,
  }) : super(key: key);
  final WidgetBuilder onBoarding;
  final WidgetBuilder nonSignedIn;
  final WidgetBuilder signedIn;

  @override
  Widget build(BuildContext context) {
    final authStateChanges = useProvider(authStateProvider);
    return authStateChanges.when(
      data: (user) => _data(context, user),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }

  Widget _data(BuildContext context, User user) {
    if (onBoarding != null && !useOnboardingListener().value) return onBoarding(context);
    if (user != null) return signedIn(context);
    return nonSignedIn(context);
  }
}
