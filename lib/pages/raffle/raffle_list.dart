import 'dart:async';

import 'package:bnv/common_widgets/platform_alert_dialog.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/services/interfaces/db_service.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:provider/provider.dart';

class RaffleListPage extends StatelessWidget {
  final Object arguments;
  final String dummyProfilePic = "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg";

  RaffleListPage({Key key, this.arguments}) : super(key: key);

  Future<void> _signOut(BuildContext context, AuthService authService) async => await authService.signOut();

  Future<void> _confirmSignOut(BuildContext context, AuthService authService) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context, authService);
    }
  }

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);
    var firestoreDB = Provider.of<DBService>(context);
    return new Scaffold(
      body: StreamBuilder(
        stream: firestoreDB.getRaffles(),
        builder: (BuildContext context, AsyncSnapshot<List<Raffle>> snapshot) {
          if (!snapshot.hasData)
            return new Text("noData");

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new FloatingSearchBar(
              children: snapshot.data.map((raffle) {
                return Column(
                    children: [
                      _buildRaffleItem(raffle),
                      Divider(
                        height: 2.0,
                        color: Colors.green,
                      ),
                    ]
                );
              }).toList(),
              trailing: _buildTrailer(authService),
              drawer: _buildDrawer(),
              onChanged: (String value) {},
              onTap: () {},
              decoration: InputDecoration.collapsed(
                hintText: "Search...",
              ),
            ),
          );
        },
      )
  );
  }

  Widget _buildTrailer(AuthService authService) {
    return FutureBuilder(
      future: authService.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        String avatar = dummyProfilePic;
        avatar = snapshot.data.profilePicUrl;
        return ButtonTheme(
          minWidth: 1.0,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            onPressed: () => _confirmSignOut(context, authService),
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

  Widget _buildRaffleItem(Raffle raffle) {
    return Container(
      child: ListTile(
        leading: Image.network(raffle.productInfo.images[0]['path']),
        title: HtmlTextView(data: raffle.title),
        subtitle: HtmlTextView(data: raffle.description),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(),
    );
  }
}
