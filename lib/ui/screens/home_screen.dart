import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/home";

  HomeScreen({Key key});

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
  AuthViewModel viewModel = AuthViewModel();

  //
  // int _currentIndex = 0;
  // List<Widget> _pages = [
  //   RaffleListScreen(),
  //   WinnersScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                User _user = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(_user.email),
                      SizedBox(height: 20),
                      Text(_user.fullname),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.blue,
                        child: Text("LOGOUT", style: TextStyle(color: Colors.white)),
                        onPressed: () async => await viewModel.signOut(),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                );
              }
              return Container();
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    // return Scaffold(
    //   body: _pages[_currentIndex],
    //   bottomNavigationBar: Padding(
    //     padding: const EdgeInsets.only(bottom: 16.0),
    //     child: CustomNavigationBar(
    //       borderRadius: Radius.circular(30.0),
    //       selectedColor: Colors.white,
    //       unSelectedColor: Colors.white38,
    //       backgroundColor: lightPrimaryColor,
    //       currentIndex: _currentIndex,
    //       scaleFactor: 0.4,
    //       isFloating: true,
    //       items: _getBottomNavigationItems(context),
    //       onTap: _onTapped,
    //     ),
    //   ),
    // );
  }

// List<CustomNavigationBarItem> _getBottomNavigationItems(BuildContext context) {
//   return [
//     CustomNavigationBarItem(icon: FontAwesomeIcons.ticketAlt),
//     CustomNavigationBarItem(icon: FontAwesomeIcons.trophy),
//   ];
// }
//
// void _onTapped(int value) {
//   setState(() {
//     _currentIndex = value;
//   });
// }
}
