import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/profile/profile_screen.dart';
import 'package:BedavaNeVar/ui/screens/raffles/raffles_screen.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends HookWidget {
  // final dummyPic =
  //     "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Home_Dummy_Avatar_Person_AI-512.png";
  final route = "/home";
  final List<Widget> _pages = [
    RafflesScreen(),
    ProfileScreen(),
  ];

  final _currentIndex = useState(0);

  HomeScreen({Key key}) : super(key: key);

  HomeScreen.navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex.value],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: CustomNavigationBar(
          borderRadius: Radius.circular(30.0),
          selectedColor: Colors.white,
          unSelectedColor: Colors.white38,
          backgroundColor: lightPrimaryColor,
          currentIndex: _currentIndex.value,
          scaleFactor: 0.4,
          isFloating: true,
          items: _getBottomNavigationItems(context),
          onTap: (value) => _currentIndex.value = value,
        ),
      ),
    );
  }

  List<CustomNavigationBarItem> _getBottomNavigationItems(BuildContext context) => [
        CustomNavigationBarItem(icon: Icon(FontAwesomeIcons.ticketAlt)),
        CustomNavigationBarItem(icon: Icon(FontAwesomeIcons.trophy)),
      ];
}
