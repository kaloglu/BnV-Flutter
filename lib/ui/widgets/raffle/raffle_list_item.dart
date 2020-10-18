import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleListItem extends StatelessWidget {
  final RaffleViewModel viewModel;
  final Function(RaffleViewModel) onTap;

  const RaffleListItem({this.viewModel, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: SizedBox(
              child: Image.network(
                viewModel.productImages.first.path,
                fit: BoxFit.cover,
              ),
            ),
            title: Html(data: viewModel.raffleTitle),
            subtitle: Html(data: viewModel.raffleDescription),
            onTap: () => onTap(viewModel),
          ),
        ),
        Divider(
          indent: 16,
          endIndent: 16,
          height: 2.0,
          color: Colors.black26,
        ),
      ]),
    );
  }
}
