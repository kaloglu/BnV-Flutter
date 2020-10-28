import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/screens/auth/login_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  static const route = "/profile";

  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  static navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushNamed(context, route);
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  @override
  Widget build(BuildContext context) {
    var authViewModel = AuthViewModel();

    return FutureBuilder<User>(
        future: authViewModel.user,
        builder: (context, snapshot) {
          User user;
          if (snapshot.hasData) {
            user = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text("Profile: ${user?.fullname}"),
                actions: [LogoutButton(onPressed: () => _onLogout(authViewModel))],
              ),
              body: Container(child: Text("test ${user.email}")),
            );
          }

          return Center(
            child: SizedBox(width: 150, height: 150, child: CircularProgressIndicator()),
          );
        });
  }

  _onLogout(AuthViewModel viewModel) async {
    await viewModel.signOut().whenComplete(() {
      LoginScreen.navigate(context);
    });
  }
}
