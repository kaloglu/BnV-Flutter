import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
import 'package:BedavaNeVar/ui/screens/raffle/raffle_list_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/stream_loading.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthViewModel>(
      viewModel: Provider.of(context),
      onModelReady: (viewModel) => viewModel?.init(),
      builder: (context, viewModel, child) {
        return StreamLoading<User>(
          context: context,
          stream: viewModel.stateChanges,
          builder: (context, snapshot, loadingDialog) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              if (user.uid != null) {
                SchedulerBinding.instance.addPostFrameCallback((duration) {
                  RaffleListScreen.navigate(context);
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
      },
    );
  }
}
