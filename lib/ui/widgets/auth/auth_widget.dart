import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_page.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class AuthWidget extends HookWidget {
  const AuthWidget({
    Key key,
    @required this.signedIn,
    this.nonSignedIn,
  }) : super(key: key);
  final WidgetBuilder signedIn;
  final WidgetBuilder nonSignedIn;

  @override
  Widget build(BuildContext context) {
    final authStateChanges = useProvider(authStateProvider);
    return authStateChanges.when(
      data: (user) {
        if (user != null) return signedIn(context);
        return nonSignedIn ?? SignInPage();
      },
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
}
