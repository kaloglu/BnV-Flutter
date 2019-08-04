import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/ui/pages/raffle/detail/raffle_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class RaffleDetailPage extends StatefulWidget {
  final Raffle raffle;

  RaffleDetailPage({Key key, this.raffle}) : super(key: key);

  @override
  _RaffleDetailPageState createState() => new _RaffleDetailPageState();
}

class _RaffleDetailPageState extends State<RaffleDetailPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: SizedBox(
                      width: 280,
                      height: 38,
                      child: Container(
                          decoration: BoxDecoration(color: Colors.black12),
                          child: HtmlTextView(data: widget.raffle.title)),
                    ),
                    background: Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Image.network(
                        widget.raffle.productInfo.images[0]['path'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: RaffleTabs(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
