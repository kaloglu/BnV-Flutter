import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/raffle/raffle_list_screen.dart';
import 'package:BedavaNeVar/ui/screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/";

  HomeScreen({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static void navigate(BuildContext context) => Navigator.pushReplacementNamed(context, route);
}

class _HomeScreenState extends State<HomeScreen> {
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Home_Dummy_Avatar_Person_AI-512.png";

  int _currentIndex = 0;
  List<Widget> _pages = [
    RaffleListScreen(),
    WinnersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // var authViewModel = Provider.of<AuthViewModel>(context);
    // var user = Provider.of<User>(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _getBottomNavigationItems(context),
        onTap: _onTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.ticketAlt),
        label: "Çekilişler",
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.trophy),
        label: "Kazananlar",
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.user),
        label: "Profil",
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
    ];
  }

  void _onTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
