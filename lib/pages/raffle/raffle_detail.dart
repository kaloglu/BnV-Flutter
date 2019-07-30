import 'package:flutter/material.dart';

class RaffleDetailPage extends StatefulWidget {
  final String raffleId;

  RaffleDetailPage({Key key, this.raffleId}) : super(key: key);

  @override
  _RaffleDetailPageState createState() => new _RaffleDetailPageState();
}

class _RaffleDetailPageState extends State<RaffleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('FilledStacks'),
              background: Image.network('https://i.ytimg.com/vi/e5bklM7YfIo/maxresdefault.jpg', fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Text("Test + ${widget.raffleId}"),
          ),
        ],
      ),

    );
  }
}
