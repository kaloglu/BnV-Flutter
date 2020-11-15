import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/raffles/raffles_screen.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushReplacementNamed(context, route);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // final dummyPic =
  //     "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Home_Dummy_Avatar_Person_AI-512.png";

  int _currentIndex = 0;
  List<Widget> _pages = [
    RafflesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomNavigationBar(
          borderRadius: Radius.circular(30.0),
          selectedColor: Colors.white,
          unSelectedColor: Colors.white38,
          backgroundColor: lightPrimaryColor,
          currentIndex: _currentIndex,
          scaleFactor: 0.4,
          isFloating: true,
          items: _getBottomNavigationItems(context),
          onTap: _onTapped,
        ),
      ),
    );
  }

  List<CustomNavigationBarItem> _getBottomNavigationItems(BuildContext context) {
    return [
      CustomNavigationBarItem(icon: FontAwesomeIcons.ticketAlt),
      CustomNavigationBarItem(icon: FontAwesomeIcons.trophy),
    ];
  }

  void _onTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
