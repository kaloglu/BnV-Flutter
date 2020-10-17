import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/provider_setup.dart';
import 'package:BedavaNeVar/ui/screens/auth/login_screen.dart';
import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const route = "/profile";
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";
  final BuildContext context;

  ProfileScreen({Key key, this.context}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  static void navigate(BuildContext context) => Navigator.pushNamed(context, route);
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthViewModel authViewModel;

  User user;

  @override
  Widget build(BuildContext context) {
    return BaseWidget2<AuthViewModel, User>(
      viewModel: Provider.of(context),
      object: Provider.of(context),
      builder: (context, viewModel, user, _) {
        if (user != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile: ${user?.fullname}"),
              actions: [
                LogoutButton(
                  onPressed: () => {_onLogout(viewModel)},
                ),
              ],
            ),
            body: Container(
              child: Text("test ${user.uid}"),
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<void> _onLogout(AuthViewModel viewModel) async {
    await viewModel.signOut().whenComplete(() {
      LoginScreen.navigate(context);
    });
  }
}
