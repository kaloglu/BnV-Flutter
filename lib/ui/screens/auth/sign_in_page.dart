import 'dart:math';

import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/show_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme_viewmodel.dart';

class SignInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final signInModel = watch(signInModelProvider);
    return ProviderListener<SignInViewModel>(
      provider: signInModelProvider,
      onChange: (context, model) async {
        if (model.error != null) {
          await showExceptionAlertDialog(
            context: context,
            title: Strings.signInFailed,
            exception: model.error,
          );
        }
      },
      child: SignInPageContents(
        viewModel: signInModel,
        title: 'Architecture Demo',
      ),
    );
  }
}

class SignInPageContents extends StatelessWidget {
  const SignInPageContents({
    Key key,
    this.viewModel,
    this.title = 'BnV Demo',
  }) : super(key: key);
  final SignInViewModel viewModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Center(
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
                onPressed: () {
                  return context.read(themeViewModel).setMode(ThemeMode.dark);
                },
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
                  return context.read(themeViewModel).setMode(ThemeMode.light);
                },
                // onPressed: viewModel.isLoading ? null : viewModel.signInFacebook,
                borderRadius: 10,
              ),
            ],
          ),
        );
      }),
    );
  }
}
