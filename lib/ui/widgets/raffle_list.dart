import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:bnv/viewmodels/raffle_list_viewmodel.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/ui/pages/base/base_widget.dart';
import 'package:bnv/ui/pages/raffle/detail/raffle_detail_page.dart';
import 'package:bnv/ui/widgets/raffle_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaffleList extends StatelessWidget {
  const RaffleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RaffleListViewModel>(
        viewModel: RaffleListViewModel(repository: Provider.of(context)),
        onModelReady: (viewModel) => viewModel.load(Provider.of<User>(context).uid),
        builder: (context, viewModel, child) => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => StreamBuilder<List<RaffleViewModel>>(
                  stream: viewModel.viewModelList$,
                  builder: (context, AsyncSnapshot<List<RaffleViewModel>> snapshot) {
                    Widget widget;
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                      case ConnectionState.active:
                        return RaffleListItem(
                          viewModel: snapshot.data[index],
                          onTap: () => RaffleDetailPage.navigate(context, snapshot.data[index]),
                        );
                        break;
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        widget = CircularProgressIndicator();
                        break;
                    }
                    return widget;
                  }),
            ));
  }
}
