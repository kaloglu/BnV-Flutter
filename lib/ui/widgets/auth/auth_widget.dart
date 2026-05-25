import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_page.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({
    super.key,
    required this.signedIn,
    this.nonSignedIn,
  });
  final WidgetBuilder signedIn;
  final WidgetBuilder? nonSignedIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateProvider);
    return authStateChanges.when(
      data: (user) {
        if (user != null) return signedIn(context);
        return nonSignedIn != null ? nonSignedIn!(context) : const SignInPage();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Bir sorun oluştu',
          message: 'Veriler şu anda yüklenemiyor.',
        ),
      ),
    );
  }
}
