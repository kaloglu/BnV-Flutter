import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/utils/page_navigator.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';
import 'package:provider/provider.dart';

class RaffleDetailScreen extends StatelessWidget {
  static const route = "/raffle_detail";

  final RaffleViewModel viewModel;

  RaffleDetailScreen({Key key, this.viewModel}) : assert(viewModel != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(viewModel.raffleTitle)),
      body: Center(
        child: RaffleDetail(viewModel, Provider.of<User>(context).uid),
      ),
    );
  }

  static void navigate(BuildContext context, RaffleViewModel raffleBloc) =>
      ScreenNavigator.navigate<RaffleViewModel>(context, route, argument: raffleBloc);
}
