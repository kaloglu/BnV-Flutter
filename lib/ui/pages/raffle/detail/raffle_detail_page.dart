import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/widgets/raffle_detail.dart';
import 'package:bnv/utils/page_navigator.dart';
import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class RaffleDetailPage extends StatelessWidget {
  static const route = "raffle_detail";

  final RaffleViewModel viewModel;

  RaffleDetailPage({Key key, this.viewModel}) : assert(viewModel != null);

  static void navigate(BuildContext context, RaffleViewModel raffleBloc) =>
      PageNavigator.navigate<RaffleViewModel>(context, route, argument: raffleBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Html(data: viewModel.raffleTitle)),
      body: Center(
        child: RaffleDetail(viewModel, Provider
            .of<User>(context)
            .uid),
      ),
    );
  }

}
