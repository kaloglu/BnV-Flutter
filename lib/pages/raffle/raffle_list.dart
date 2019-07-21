import 'dart:async';

import 'package:bnv/common_widgets/platform_alert_dialog.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/db/firestore_service_adapter.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:provider/provider.dart';

class RaffleListPage extends StatefulWidget {
  final Object arguments;
  final DBServiceAdapter _firestoreDB = DBServiceAdapter();

  RaffleListPage({Key key, this.arguments}) : super(key: key);

  @override
  _RaffleListPageState createState() => new _RaffleListPageState();
}

class _RaffleListPageState extends State<RaffleListPage> {
  AuthService authService;
  User user;

  var dummyProfilePic = "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg";

  @override
  Stream initState() async* {
    authService = Provider.of<AuthService>(context);
    user = await authService.currentUser();
    setState(() {
      dummyProfilePic = user.profilePicUrl;
    });
    super.initState();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await authService.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      body: StreamBuilder(
        stream: widget._firestoreDB.getRaffles(),
        builder: (BuildContext context, AsyncSnapshot<List<Raffle>> snapshot) {
          if (!snapshot.hasData)
            return new Text("noData");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new FloatingSearchBar(
              children: snapshot.data.map((raffle) {
                return Column(
                    children: [
                      _buildListRaffle(raffle),
                      Divider(
                        height: 2.0,
                        color: Colors.green,
                      ),
                    ]
                );
              }).toList(),
              trailing: CircleAvatar(
                radius: 20.0,
                backgroundImage:
                NetworkImage(dummyProfilePic),
                backgroundColor: Colors.transparent,
              ),
              drawer: Drawer(
                child: Container(),
              ),
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

  Widget _buildListRaffle(Raffle raffle) {
    return Container(
      child: ListTile(
        leading: Image.network(raffle.productInfo.images[0]['path']),
        title: HtmlTextView(data: raffle.title),
        subtitle: HtmlTextView(data: raffle.description),
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<List<Raffle>> snapshot) {

  }
}
