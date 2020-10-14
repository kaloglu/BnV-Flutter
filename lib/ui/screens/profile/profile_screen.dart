import 'package:BedavaNeVar/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  ProfileScreen({Key key});

  @override
  Widget build(BuildContext context) {
    // var authViewModel = Provider.of<AuthViewModel>(context);
    // var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Container(
        child: Text("ProfileScreen"),
      ),
    );
  }
}
