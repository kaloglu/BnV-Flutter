import 'package:bnv/constants/strings.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/pages/base/base_widget.dart';
import 'package:bnv/ui/pages/raffle/raffle_list_page.dart';
import 'package:bnv/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

import 'common/stream_loading.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthViewModel>(
        viewModel: Provider.of(context),
        onModelReady: (viewModel) => viewModel?.init(),
        builder: (context, viewModel, child) {
          return StreamLoading<User>(
//            loadingDialog: ProgressDialog(context, ProgressDialogType.Normal),
            stream: viewModel.onAuthStateChanged,
            builder: (context, snapshot, loadingDialog) {
              User user;

              if (snapshot.hasData) {
//                SchedulerBinding.instance.addPostFrameCallback((duration) {
//                  loadingDialog.hide();
//                });
                user = snapshot.data;
                if (user.uid != null) {
                  SchedulerBinding.instance.addPostFrameCallback((duration) {
                    RaffleListPage.navigate(context);
                  });
                }
              }

              return Center(
                child: Container(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                              Strings.BnV,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            Text(
                              Strings.signIn,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 36.0),
                      GoogleSignInButton(
                        text: Strings.signInWithGoogle,
                        onPressed: () async => await viewModel.signInWithGoogle(context),
                        darkMode: true,
                        borderRadius: 10,
                      ),
                      SizedBox(height: 8),
                      FacebookSignInButton(
                        text: Strings.signInWithFacebook,
                        onPressed: () async => await viewModel.signInWithFacebook(context),
                        borderRadius: 10,
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
