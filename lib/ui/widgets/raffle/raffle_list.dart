import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/viewmodels/rafles.dart';
import 'package:provider/provider.dart';

class RaffleList extends StatefulWidget {
  const RaffleList({Key key}) : super(key: key);

  @override
  _RaffleListState createState() => _RaffleListState();
}

class _RaffleListState extends State<RaffleList> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<RaffleListViewModel>(
        viewModel: Provider.of(context),
        onModelReady: (viewModel) => viewModel?.load(),
        builder: (context, viewModel, child) {
          return StreamBuilder<List<RaffleViewModel>>(
            stream: viewModel.raffleViewModelList$,
            builder: (context, raffleViewModelList) {
              List<RaffleViewModel> listOfViewModels = raffleViewModelList.hasData ? raffleViewModelList.data : [];

              if (listOfViewModels.isEmpty) return EmptyRaffleList();

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listOfViewModels.length,
                itemBuilder: (context, index) => RaffleListItem(
                  viewModel: listOfViewModels[index],
                  onTap: () {
                    RaffleDetailScreen.navigate(context, listOfViewModels[index]);
                  },
                ),
              );
            },
          );
        });
  }
}

class EmptyRaffleList extends StatelessWidget {
  const EmptyRaffleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Kampanya bulunamadı"));
  }
}
