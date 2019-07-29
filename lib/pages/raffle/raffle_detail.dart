import 'package:flutter/material.dart';

class RaffleDetailPage extends StatefulWidget {
  final Object arguments;

  RaffleDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _RaffleDetailPageState createState() => new _RaffleDetailPageState();
}

class _RaffleDetailPageState extends State<RaffleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("[TITLE]"),
      ),
      body: new Text("RaffleDetailPage"),
    );
  }
}
