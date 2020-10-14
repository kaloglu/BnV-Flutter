import 'package:BedavaNeVar/constants/constants.dart';

class WinnersScreen extends StatelessWidget {
  WinnersScreen({Key key});

  @override
  Widget build(BuildContext context) {
    // var authViewModel = Provider.of<AuthViewModel>(context);
    // var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(title: Text("user.fullname")),
      body: Container(
        child: Text("WinnersScreen"),
      ),
    );
  }
}
