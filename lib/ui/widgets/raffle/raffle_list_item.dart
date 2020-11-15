import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RaffleListItem extends StatelessWidget {
  final Raffle item;
  final Function(Raffle) onTap;

  const RaffleListItem({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: SizedBox(
              child: SvgPicture.asset("assets/icons/facebook.svg"),
              // child: Image.network(
              //   viewModel.productImages.first.path,
              //   fit: BoxFit.cover,
              // ),
            ),
            title: Html(data: "title"),
            subtitle: Html(data: "description"),
            onTap: () => {}, //onTap(viewModel),
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
