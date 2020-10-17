import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/widgets/common/Buttons.dart';
import 'package:BedavaNeVar/ui/widgets/common/platform_alert_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class RaffleListScreen extends StatelessWidget {
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";

  static const route = "/raffle_list";

  static void navigate(BuildContext context) => ScreenNavigator.navigate(
        context,
        route,
        canBack: false,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FloatingSearchBar(
            children: [
              RaffleList(),
            ],
            trailing: SortButton(
              onPressed: () => {
                PlatformAlertDialog(
                  title: "Warning",
                  content: "Sıralama yapılacak",
                  defaultActionText: "OK",
                ).show(context)
              },
            ),
            leading: _buildProfilePhoto(context),
            pinned: false,
            padding: EdgeInsets.only(top: 8.0),
            onChanged: (String value) {},
          ),
        ),
      );

  Widget _buildProfilePhoto(BuildContext context) {
    return BaseWidget2<AuthViewModel, User>(
      viewModel: Provider.of(context),
      object: Provider.of(context),
      builder: (context, viewModel, user, _) {
        var profilePicUrl = user.profilePicUrl ?? dummyPic;
        return ButtonTheme(
          minWidth: 1.0,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            onPressed: () => {ProfileScreen.navigate(context)},
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
}
