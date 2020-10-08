// import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
//
// class RaffleListItem extends StatelessWidget {
//   final RaffleViewModel viewModel;
//   final Function onTap;
//
//   const RaffleListItem({this.viewModel, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 75,
//       child: Column(children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: ListTile(
//             leading: SizedBox(
//               width: 75,
//               child: Image.network(
//                 viewModel.productImages[0]['path'],
//                 fit: BoxFit.scaleDown,
//               ),
//             ),
//             title: Html(data: viewModel.raffleTitle),
// //            subtitle: Html(data: raffle.description),
//             onTap: onTap,
//           ),
//         ),
//         Divider(
//           indent: 16,
//           endIndent: 16,
//           height: 2.0,
//           color: Colors.black26,
//         ),
//       ]),
//     );
//   }
// }
