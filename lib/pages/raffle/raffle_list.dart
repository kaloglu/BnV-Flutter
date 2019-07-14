import 'package:bnv/firebase/auth.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class RaffleListPage extends StatefulWidget {
  final Object arguments;

  RaffleListPage({Key key, this.arguments}) : super(key: key);

  @override
  _RaffleListPageState createState() => new _RaffleListPageState();
}

class _RaffleListPageState extends State<RaffleListPage> {
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
              onPressed: () => Authorization().signOut().whenComplete((){
                PageNavigator.goSplash(context);
              }),
            ),
          ],
        ),
      ));
}
