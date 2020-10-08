// import 'package:BedavaNeVar/model/user_model.dart';
// import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
// import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
// import 'package:BedavaNeVar/viewmodels/raffle_list_viewmodel.dart';
// import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../common/stream_loading.dart';
// import '../raffle_list_item.dart';
//
// class RaffleList extends StatelessWidget {
//   const RaffleList({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget<RaffleListViewModel>(
//         viewModel: Provider.of(context),
//         onModelReady: (viewModel) => viewModel?.load(Provider.of<User>(context).uid),
//         builder: (context, viewModel, child) {
//           return StreamLoading<List<RaffleViewModel>>(
// //            loadingDialog: ProgressDialog(context, ProgressDialogType.Normal),
//             stream: viewModel.raffleList$,
//             builder: (context, snapshot, loadingDialog) {
//               List<RaffleViewModel> data = [];
//
//               if (snapshot.hasData) {
// //                SchedulerBinding.instance.addPostFrameCallback((duration) {
// //                  loadingDialog.hide();
// //                });
//                 data = snapshot.data;
//               }
//
//               return ListView.builder(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: data.length,
//                   itemBuilder: (context, index) {
//                     if (!snapshot.hasData) return Container();
//                     return RaffleListItem(
//                       viewModel: data[index],
//                       onTap: () {
//                         RaffleDetailScreen.navigate(context, data[index]);
//                       },
//                     );
//                   });
//             },
//           );
//         });
//   }
// }
