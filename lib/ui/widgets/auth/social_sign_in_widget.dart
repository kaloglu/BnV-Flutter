import 'dart:math';

import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/progress_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/common/show_exception_alert_dialog.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SocialSignIn extends HookWidget {
  final _viewModel = useProvider(signInModelProvider);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<SignInViewModel>(
      provider: signInModelProvider,
      onChange: (context, viewModel) async {
        if (viewModel.error != null) {
          await showExceptionAlertDialog(
            context: context,
            title: Strings.signInFailed,
            exception: viewModel.error,
          );
        }
        if (viewModel.isLoading) {
          ProgressDialog().show();
        }
      },
      child: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: min(constraints.maxWidth, 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 32.0),
                SizedBox(
                  height: 100.0,
                  child: _buildHeader(),
                ),
                const SizedBox(height: 32.0),
                GoogleSignInButton(
                  text: Strings.signInWithGoogle,
                  onPressed: _viewModel.signInGoogle,
                  // onPressed: viewModel.isLoading ? null : () => viewModel.signInGoogle,
                  borderRadius: 10,
                ),
                const SizedBox(height: 8),
                const Text(
                  Strings.or,
                  style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                FacebookSignInButton(
                  text: Strings.signInWithFacebook,
                  onPressed: () {
                    return _viewModel.signInFacebook();
                  },
                  // onPressed: viewModel.isLoading ? null : viewModel.signInFacebook,
                  borderRadius: 10,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }
}
