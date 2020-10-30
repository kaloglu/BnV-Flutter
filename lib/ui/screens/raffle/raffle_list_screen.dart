import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_alert_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:BedavaNeVar/viewmodels/raffles.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

import '../screens.dart';

class RaffleListScreen extends StatefulWidget {
  static const route = "/raffle_list";

  @override
  _RaffleListScreenState createState() => _RaffleListScreenState();
}

class _RaffleListScreenState extends State<RaffleListScreen> {
  RaffleListViewModel viewModel;

  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  @override
  void initState() {
    super.initState();
    viewModel = RaffleListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RaffleViewModel>>(
        stream: RaffleListViewModel().getRaffleListViewModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    "Kampanya bulunamadı!",
                  ),
                ),
              ),
            );
          }

          var list = snapshot.data;
          return Scaffold(
            body: FloatingSearchBar.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return RaffleListItem(
                  viewModel: list[index],
                  onTap: (itemModel) {
                    PlatformAlertDialog(
                      title: "Warning",
                      content: itemModel.raffleTitle,
                      defaultActionText: "OK",
                    ).show(context);
                  },
                );
              },
              trailing: SortButton(
                onPressed: () => {
                  PlatformAlertDialog(
                    title: "Warning",
                    content: "Sıralama yapılacak",
                    defaultActionText: "OK",
                  ).show(context)
                },
              ),
              leading: _buildProfilePhoto(),
              pinned: false,
              padding: EdgeInsets.only(top: 8.0),
              onChanged: (String value) {},
            ),
          );
        });
  }

  Widget _buildProfilePhoto() {
    return FutureBuilder<User>(
      future: AuthViewModel().getUser(),
      builder: (context, snapshot) {
        var user = snapshot.data;
        var profilePicUrl = user?.profilePicUrl ?? dummyPic;
        return ButtonTheme(
          minWidth: 1.0,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            onPressed: () => ProfileScreen.navigate(context),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(profilePicUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  onSortButtonClick(BuildContext context) {
    PlatformAlertDialog(
      title: "Warning",
      content: "Sıralama yapılacak",
      defaultActionText: "OK",
    ).show(context);
  }

  void onSearchTextChanged(String value) {}
}
