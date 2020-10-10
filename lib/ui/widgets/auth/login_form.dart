import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/raffle/raffle_list_screen.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: GoogleSignInButton(
              text: Strings.signInWithGoogle,
              onPressed: () async => RaffleListScreen.navigate(context),
              darkMode: true,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }
}
