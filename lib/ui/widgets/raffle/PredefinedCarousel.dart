import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PredefinedCarousel extends HookWidget {
  final List<Media> images;
  final bool showIndicator;
  final double _height;
  final int initialPage;

  PredefinedCarousel({@required this.images, this.showIndicator, this.initialPage, double height})
      : _height = (height == 0) ? 100 : height,
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
    var _initialPage = useState(initialPage);
    return Container(
      height: _height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).cardColor,
              child: Column(
                children: <Widget>[
                  CarouselSlider(
                      options: CarouselOptions(
                        height: _height,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        onPageChanged: (index, fn) => _initialPage.value = index,
                      ),
                      items: images
                          .map((imgUrl) => Builder(
                                builder: (BuildContext context) => CachedNetworkImage(
                                  imageUrl: imgUrl.path,
                                  progressIndicatorBuilder: (context, url, progress) =>
                                      CircularProgressIndicator(value: progress.progress),
                                ),
                              ))
                          .toList()),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(images, (index, url) {
                      return Container(
                        width: 30.0,
                        height: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          color: _initialPage.value == index ? Colors.deepPurple : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
