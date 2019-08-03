import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {

  void _handleListener(BuildContext context, AuthenticationState state) {
    if (state is HomeScreen)
      PageNavigator.goRaffleList(context);
    if (state is LoginScreen)
      PageNavigator.goLogin(context, canBack: false);
  }

  Widget _handleState(AuthenticationBloc authBloc, AuthenticationState state) {
    if (state is AuthInit)
      authBloc.dispatch(AppStarted());
    else if (state is Authenticated)
      authBloc.dispatch(GoHomeScreen(state.user));
    else if (state is Unauthenticated)
      authBloc.dispatch(GoLoginScreen());

    return _buildScreenWidget();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return new Scaffold(
        body: Center(
          child: _buildBlocListener(authBloc),
        ),
    );
  }

  Widget _buildBlocListener(AuthenticationBloc authBloc) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: _handleListener,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) => _handleState(authBloc, state)
        ),
      );

  Widget _buildScreenWidget() =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "BedavaNeVar",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          CircularProgressIndicator(),
        ],
      );

}
