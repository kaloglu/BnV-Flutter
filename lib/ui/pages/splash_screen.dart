import 'package:bnv/bloc/authentication/bloc.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthenticationBloc>(context);
    return new Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is Authenticated)
                    PageNavigator.goRaffleList(context);
                  if (state is Unauthenticated)
                    PageNavigator.goLogin(context, canBack: false);
                },
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthInit)
                        bloc.dispatch(AppStarted());

                      return Column(
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
                ),
              ),

            ],
          ),
        ),
      );
  }

}
