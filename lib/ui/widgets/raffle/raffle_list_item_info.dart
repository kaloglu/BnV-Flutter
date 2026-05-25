import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleListItemInfo extends StatelessWidget {
  final Raffle item;

  const RaffleListItemInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            item.title,
            style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Html(
            data: item.description,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}
