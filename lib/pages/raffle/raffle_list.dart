import 'package:bnv/common_widgets/platform_alert_dialog.dart';
import 'package:bnv/constants/strings.dart';
import 'package:bnv/services/interfaces/auth_service.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaffleListPage extends StatefulWidget {
  final Object arguments;

  RaffleListPage({Key key, this.arguments}) : super(key: key);

  @override
  _RaffleListPageState createState() => new _RaffleListPageState();
}

class _RaffleListPageState extends State<RaffleListPage> {

  Future<void> _signOut(BuildContext context) async {
    try {
      await Provider.of<AuthService>(context).signOut();
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
      appBar: new AppBar(
        title: new Text("[TITLE]"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            new RaisedButton(
              child: Text("RaffleListPage"),
              onPressed: () => PageNavigator.goRaffleDetail(context),
            ),
            new RaisedButton(
              child: Text("Sign out"),
              onPressed: () => _confirmSignOut(context),
            ),
          ],
        ),
      ));
}
