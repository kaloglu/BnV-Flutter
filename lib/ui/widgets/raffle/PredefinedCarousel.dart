import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
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

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = useState(initialPage);
    ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildIndicator(screenSize, themeData, _selectedIndex.value),
            _buildCarousel(context, screenSize, themeData, _selectedIndex),
            _buildIndicator(screenSize, themeData, _selectedIndex.value),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselBottomWidget(BuildContext context, {double height, Color color, item}) => Container(
      height: height,
      color: (color ?? Theme.of(context).primaryColor).withOpacity(0.3),
      child: ListTile(
//        leading: Center(
//          widthFactor: 1,
//          child: Expanded(
//            child: Text(
//              "${viewModel.productCount}  ${viewModel.productUnit}",
//              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
//            ),
//          ),
//        ),
        title: Text(item.productInfo.name, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(text: Strings.currentValue + ": ", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: item.productInfo.unitPrice.toString()),
              TextSpan(text: " " + Strings.tlChar, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ));

  Widget _buildCarousel(BuildContext context, Size screenSize, ThemeData themeData, ValueNotifier<int> _selectedIndex) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Center(
          child: images.length != 1
              ? CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: (images.length != 1),
                    reverse: true,
                    onPageChanged: (index, fn) => _selectedIndex.value = index,
                  ),
                  items: images
                      .map((imgUrl) =>
                          Builder(builder: (BuildContext context) => CachedNetworkImage(imageUrl: imgUrl.path)))
                      .toList(),
                )
              : CachedNetworkImage(height: screenSize.height / 2.5, imageUrl: images[0].path),
        ),
        _buildCarouselBottomWidget(context, item: raffle),
      ],
    );
  }

  Widget _buildIndicator(Size screenSize, ThemeData themeData, selectedIndex) {
    return (showIndicator && (images.length != 1))
        ? Row(
            children: map<Widget>(images, (index, url) {
              return Container(
                // child: Text(getOpacity(selectedIndex, index).toString()),
                width: (screenSize.width / images.length),
                height: 10.0,
                decoration:
                    BoxDecoration(color: themeData.indicatorColor.withOpacity(getOpacity(selectedIndex, index))),
              );
            }),
          )
        : Container();
  }

  double getOpacity(selectedIndex, index) => ((images.length - (index - selectedIndex).abs())) / (images.length);
}
