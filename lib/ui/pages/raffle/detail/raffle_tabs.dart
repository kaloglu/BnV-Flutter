
import 'package:flutter/material.dart';

class TabData {
  final String label;
  final Widget child;

  TabData(this.label, this.child);
}

class RaffleTabs extends StatelessWidget {
  final List<TabData> _tabs = [
    TabData("Çekiliş Bilgileri", Container(color: Colors.blue)),
    TabData("Ürün Detayı", Container(color: Colors.red)),
    TabData("Kurallar", Container(color: Colors.green)),
  ];

  Widget _buildTabBar() {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.indigo,
      tabs: _tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() => Expanded(
        child: TabBarView(
          children: _tabs.map((tab) => tab.child).toList(),
        ),
      );

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _tabs.length,
        initialIndex: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(30),
//              topRight: Radius.circular(30),
//            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTabBar(),
              _buildTabContent(),
            ],
          ),
        ),
      );
}
