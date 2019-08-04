import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatelessWidget {

  void _handleListener(BuildContext context, AuthenticationState state) {
    if (state is HomeScreen)
      PageNavigator.goRaffleList(context);
  }

  Widget _handleState(BuildContext context, AuthenticationState state) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    if (state is HomeScreen)
      authBloc.dispatch(GoHomeScreen(state.user));

    if (state is LoginScreen || state is Unauthenticated)
      return _buildLoginScreen(context, authBloc);

    return _buildLoading();
  }

  Widget _buildLoading() =>
      Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) =>
      Scaffold(
      backgroundColor: Colors.grey[200],
        body: _buildBlocListener(context),
    );

  Widget _buildBlocListener(BuildContext context) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: _handleListener,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: _handleState,
        ),
      );

  Widget _buildHeader() =>
      Column(
        children: <Widget>[
          Text(
            Strings.BnV,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10),),
          Text(
            Strings.signIn,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ],
      );

  Widget _buildLoginScreen(BuildContext context, AuthenticationBloc authBloc) =>
      Container(
        padding: EdgeInsets.all(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 36.0),
          GoogleSignInButton(
            text: Strings.signInWithGoogle,
            onPressed: () => authBloc.signInWithGoogle(context),
            darkMode: true,
            borderRadius: 10,
          ),
          SizedBox(height: 8),
          FacebookSignInButton(
            text: Strings.signInWithFacebook,
            onPressed: () => authBloc.signInWithFacebook(context),
            borderRadius: 10,
          ),
          SizedBox(height: 8),
        ],
      ),
    );
}