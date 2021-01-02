import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/auth/sign_in_viewmodel.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookWidget {
  static final route = "/profile";

  final authViewModel = useProvider(signInModelProvider);

  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  ProfileScreen({Key key}) : super(key: key);

  ProfileScreen.navigate(BuildContext context) {
    print("page: $route");
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    User user = authViewModel.auth.getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile: ${user?.fullname}"),
        actions: [LogoutButton(onPressed: _onLogout)],
      ),
      body: Container(child: Text("test ${user?.email}")),
    );
  }

  _onLogout() async {
    authViewModel.signOut();
    /*.whenComplete(() {
      LoginScreen.navigate(context);
    });*/
  }
}
