import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/stream_loading.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/viewmodels/rafles.dart';
import 'package:provider/provider.dart';

class RaffleList extends StatelessWidget {
  const RaffleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RaffleListViewModel>(
        viewModel: Provider.of(context),
        onModelReady: (viewModel) => viewModel?.load(),
        builder: (context, viewModel, child) {
          return StreamLoading<List<RaffleViewModel>>(
//            loadingDialog: ProgressDialog(context, ProgressDialogType.Normal),
            stream: viewModel.raffleList$,
            builder: (context, snapshot /*, loadingDialog*/) {
              List<RaffleViewModel> data = [];

              if (snapshot.hasData) {
//                SchedulerBinding.instance.addPostFrameCallback((duration) {
//                  loadingDialog.hide();
//                });
                data = snapshot.data;
              }

              return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (!snapshot.hasData) return Container();
                    return RaffleListItem(
                      viewModel: data[index],
                      onTap: () {
                        RaffleDetailScreen.navigate(context, data[index]);
                      },
                    );
                  });
            },
          );
        });
  }
}
