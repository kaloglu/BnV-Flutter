import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/common/notch.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PredefinedCarousel extends HookWidget {
  final Raffle raffle;
  final bool showIndicator;
  final int initialPage;
  final List<Media> images;

  PredefinedCarousel({
    @required this.raffle,
    this.showIndicator = true,
    this.initialPage = 0,
  })  : images = raffle.productInfo.images,
        super();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  ValueNotifier<int> _selectedIndex;

  @override
  Widget build(BuildContext context) {
    _selectedIndex = useState(initialPage);
    ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return _buildCarousel(context, screenSize, themeData, _selectedIndex.value);
  }

  Widget _buildCarouselBottomWidget(BuildContext context, {Raffle item}) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text(
              "${item.productInfo.count} ${item.productInfo.unit}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsetsDirectional.only(end: 8.0)),
            Text(item.productInfo.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  RichText _buildPrice(Raffle item) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: Strings.currentValue + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: item.productInfo.unitPrice.toString()),
          TextSpan(text: " " + Strings.tlChar, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, Size screenSize, ThemeData themeData, int selectedIndex) {
    return Container(
      height: 200,
      width: screenSize.width,
      child: Stack(
        children: [
          _buildIndicator(screenSize, themeData),
          Center(child: _buildCarouselOrSingleImage(screenSize)),
          Notch(
            position: NotchPosition.topRight(),
            color: Theme.of(context).cardColor.withOpacity(0.75),
            boxShadows: useShadowColors(context),
            child: _buildDateInfoWidget(context, raffle),
          ),
          Notch(
            position: NotchPosition.bottomCenter(),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            color: Theme.of(context).cardColor.withOpacity(0.55),
            child: _buildCarouselBottomWidget(context, item: raffle),
          )
        ],
      ),
    );
  }

  Widget _buildCarouselOrSingleImage(Size screenSize) {
    return images.length != 1
        ? CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              autoPlay: (images.length != 1),
              reverse: true,
              onPageChanged: (index, fn) => _selectedIndex.value = index,
            ),
            items: images
                .map((imgUrl) => Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(imageUrl: imgUrl.path);
                      },
                    ))
                .toList(),
          )
        : Center(child: CachedNetworkImage(height: screenSize.height / 2.5, imageUrl: images[0].path));
  }

  Widget _buildDateInfoWidget(BuildContext context, Raffle raffle) {
    return Text.rich(
      TextSpan(
        text: (true) ? "Katılım: ${raffle.startDateReadable}" : "Çekiliş: ${raffle.endDateReadable}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildIndicator(Size screenSize, ThemeData themeData) {
    return (showIndicator && (images.length != 1))
        ? Row(
            children: map<Widget>(images, (index, url) {
              var isSelected = _selectedIndex.value == index;
              return Container(
                // child: Text(getOpacity(selectedIndex, index).toString()),
                width: isSelected ? 11.0 : 10.0,
                height: isSelected ? 16.0 : 10.0,
                decoration: BoxDecoration(
                  color: themeData.indicatorColor.withOpacity(isSelected ? 1 : 0.3),
                  // color: themeData.indicatorColor.withOpacity(getOpacity(selectedIndex, index)),
                ),
              );
            }),
          )
        : Container();
  }

  double getOpacity(selectedIndex, index) => ((images.length - (index - selectedIndex).abs())) / (images.length);
}
