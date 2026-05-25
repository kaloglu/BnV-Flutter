import 'dart:math';

import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/progress_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/common/show_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SocialSignIn extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signInModelProvider);

    ref.listen<SignInViewModel>(signInModelProvider, (previous, next) async {
      if (next.error != null) {
        await showExceptionAlertDialog(
          context: context,
          title: Strings.signInFailed,
          exception: next.error,
        );
      }
      if (next.isLoading) {
        ProgressDialog().show();
      }
    });

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
              const SizedBox(
                height: 100.0,
                child: Center(
                  child: Text(
                    Strings.signIn,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.login, color: Colors.white),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                label: const Text(Strings.signInWithGoogle),
                onPressed: viewModel.signInGoogle,
              ),
            ],
          ),
        );
      }),
    );
  }
}
