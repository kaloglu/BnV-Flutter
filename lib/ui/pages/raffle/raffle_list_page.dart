import 'dart:async';

import 'package:bnv/bloc/raffle_list/bloc.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/ui/widgets/common/platform_alert_dialog.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class RaffleListPage extends StatelessWidget {
  final Object arguments;
  final String dummyProfilePic = "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg";

  RaffleListPage({Key key, this.arguments}) : super(key: key);

  List<BlocListener<Bloc, dynamic>> get _blocListeners =>
      [
        BlocListener<RaffleListBloc, RaffleListState>(
          listener: _handleRaffleListListener,
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _handleAuthenticationListener,
        ),
      ];

  void _handleAuthenticationListener(BuildContext context, AuthenticationState state) {
    if (state is Unauthenticated)
      PageNavigator.goSplash(context);
  }

  void _handleRaffleListListener(BuildContext context, RaffleListState state) {}

  Widget _handleRaffleListState(BuildContext context, RaffleListState state) {
    final raffleListBloc = BlocProvider.of<RaffleListBloc>(context);
    if (state is Loading)
      raffleListBloc.dispatch(LoadList());
    if (state is Content) {
      return _buildListView(state.data);
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaffleListBloc>(
      builder: (context) => RaffleListBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingSearchBar(
            children: [
              _buildBlocListener(),
            ],

            trailing: _buildProfilePhoto(context),
            drawer: _buildDrawer(),
            onChanged: (String value) {},
            onTap: () {},
            decoration: InputDecoration.collapsed(
              hintText: "Search...",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlocListener() =>
      MultiBlocListener(
        listeners: _blocListeners,
        child: BlocBuilder<RaffleListBloc, RaffleListState>(
          builder: _handleRaffleListState,
        ),
      );

  Widget _buildListView(List<Raffle> data) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, position) => _buildRaffleItem(context, data[position]),
      itemCount: data.length,
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    var authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return FutureBuilder(
      future: authBloc.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        String avatar = dummyProfilePic;

        if (snapshot.connectionState != ConnectionState.waiting && snapshot.hasData)
          avatar = snapshot.data.profilePicUrl;

        return ButtonTheme(
          minWidth: 1.0,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            onPressed: () => _confirmSignOut(context, authBloc),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(avatar),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRaffleItem(BuildContext context, Raffle raffle) {
    return Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 75,
              child: Image.network(
                raffle.productInfo.images[0]['path'],
                fit: BoxFit.scaleDown,
              ),
            ),
            title: HtmlTextView(data: raffle.title),
            subtitle: HtmlTextView(data: raffle.description),
            onTap: () => PageNavigator.goRaffleDetail(context, raffle),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            height: 2.0,
            color: Colors.black26,
          ),
        ]
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(),
    );
  }

  Future<void> _confirmSignOut(BuildContext context, AuthenticationBloc authBloc) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      authBloc.dispatch(LoggedOut());
    }
  }
}