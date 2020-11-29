import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/ReusableCarousel.dart';
import 'package:flutter_html/flutter_html.dart';

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
            leading: PredefinedCarousel(images: item.productInfo.images),
            title: Html(data: item.title),
            subtitle: Html(data: item.description),
            onTap: () => onTap(item),
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
