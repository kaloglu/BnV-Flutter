import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffle_list_item_info.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RaffleListItem extends StatelessWidget {
  final Raffle item;
  final Function(Raffle) onTap;
  final double height;
  final double _height;

  const RaffleListItem({
    this.item,
    this.onTap,
    this.height,
  }) : _height = (height != null) ? height : 120;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      child: Container(
        height: _height,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 5),
                    decoration: BoxDecoration(
                      color: themeData.bottomAppBarColor,
                      boxShadow: useShadowColors(context),
                    ),
                    constraints: BoxConstraints.expand(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: useShadowColors(context),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: item.productInfo.images.first.path,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(value: progress.progress),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _height + (_height / 10)),
                    child: RaffleListItemInfo(item: item),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => onTap(item),
    );
  }
}
