import 'dart:async';

import 'package:bnv/constants/strings.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/pages/auth/login_page.dart';
import 'package:bnv/ui/widgets/common/platform_alert_dialog.dart';
import 'package:bnv/ui/widgets/raffle_list.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:bnv/viewmodels/auth_viewmodel.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaffleListPage extends StatelessWidget {
  static const route = "raffle_list";
  final dummyPic =
      "https://cdn1.iconfinder.com/data/icons/circle-outlines-colored/512/Robot_User_Profile_Dummy_Avatar_Person_AI-512.png";
  static void navigate(BuildContext context) => PageNavigator.navigate(context, route, canBack: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingSearchBar(
          children: [
            RaffleList(),
          ],
          trailing: _buildProfilePhoto(context),
          drawer: _buildDrawer(),
          onChanged: (String value) {},
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "Search...",
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    var profilePicUrl = Provider
        .of<User>(context)
        ?.profilePicUrl ?? dummyPic;
    return ButtonTheme(
      minWidth: 1.0,
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        onPressed: () => _confirmSignOut(
          context,
          onPositiveButtonClick: () {
            var authViewModel = Provider.of<AuthViewModel>(context);
            authViewModel.signOut();
            LoginPage.navigate(context);
          },
          onNegativeButtonClick: () {
            print("click negative");
          },
        ),
        child: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(profilePicUrl),
          backgroundColor: Colors.transparent,
        ),
      ),
      );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(),
    );
  }

  Future<void> _confirmSignOut(BuildContext context,
      {void onPositiveButtonClick(), void onNegativeButtonClick()}) async {
    onPositiveButtonClick ??= () => {print("positive Click")};
    onNegativeButtonClick ??= () => {print("negative Click")};

    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);

    if (didRequestSignOut == true)
      onPositiveButtonClick();
    else
      onNegativeButtonClick();
  }
}
