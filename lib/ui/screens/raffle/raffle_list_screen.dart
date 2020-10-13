import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_alert_dialog.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class RaffleListScreen extends StatefulWidget {
  static const route = "raffle_list";

  @override
  _RaffleListScreenState createState() => _RaffleListScreenState();

  static void navigate(BuildContext context) => ScreenNavigator.navigate(context, route, canBack: false);
}

class _RaffleListScreenState extends State<RaffleListScreen> {
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  ScrollController _scrollController;

  bool lastStatus = true;

  double height = 200;

  void _scrollListener() {
    if (_isCollapsed != lastStatus) {
      setState(() {
        lastStatus = _isCollapsed;
      });
    }
  }

  bool get _isCollapsed => _scrollController.hasClients && _scrollController.offset > (height - kToolbarHeight);

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            brightness: Brightness.dark,
            expandedHeight: height,
            floating: true,
            pinned: true,
            snap: true,
            actions: <Widget>[
              SortButton(
                onPressed: () => {
                  PlatformAlertDialog(
                    title: "Warning",
                    content: "Sıralama yapılacak",
                    defaultActionText: "OK",
                  ).show(context)
                },
              ),
              SearchButton(
                onPressed: () => {
                  PlatformAlertDialog(
                    title: "Warning",
                    content: "Arama yapılacak",
                    defaultActionText: "OK",
                  ).show(context)
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: kPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("featured Item gösterilecek!"),
                    ),
                  ],
                ),
              ),
            ),
            title: Text("Çekiliş Listesi"),
          ),
        ],
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              height: 40,
              child: Text(index.toString()),
            );
          },
        ),
      ),
    );
  }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: FloatingSearchBar(
//         children: [
//           RaffleList(),
//         ],
//         trailing: _buildProfilePhoto(context),
//         drawer: _buildDrawer(),
//         onChanged: (String value) {},
//         onTap: () {},
//         decoration: InputDecoration.collapsed(
//           hintText: "Search...",
//         ),
//       ),
//     ),
//       );
// }
}
