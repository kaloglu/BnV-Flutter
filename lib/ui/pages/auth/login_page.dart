import 'package:bnv/constants/strings.dart';
import 'package:bnv/ui/pages/base/base_widget.dart';
import 'package:bnv/ui/pages/raffle/raffle_list_page.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:bnv/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const route = "login";

  @override
  _LoginPageState createState() => _LoginPageState();

  static void navigate(BuildContext context) => PageNavigator.navigate(context, route, canBack: false);
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) => BaseWidget<AuthViewModel>(
        viewModel: Provider.of(context),
        child: _buildHeader(),
        builder: (context, viewModel, header) => Scaffold(
          body: buildPageWidget(context, viewModel, header),
        ),
      );

  Widget buildPageWidget(context, AuthViewModel viewModel, header) => Center(
        child: Container(
          padding: EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 100.0,
                child: header,
              ),
              SizedBox(height: 36.0),
              GoogleSignInButton(
                text: Strings.signInWithGoogle,
                onPressed: () async {
                  var success = await viewModel.signInWithGoogle(context);
                  if (success) RaffleListPage.navigate(context);
                },
                darkMode: true,
                borderRadius: 10,
              ),
              SizedBox(height: 8),
              FacebookSignInButton(
                text: Strings.signInWithFacebook,
                onPressed: () async {
                  var success = await viewModel.signInWithFacebook(context);
                  if (success) RaffleListPage.navigate(context);
                },
                borderRadius: 10,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget _buildHeader() => Column(
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
      );
}
