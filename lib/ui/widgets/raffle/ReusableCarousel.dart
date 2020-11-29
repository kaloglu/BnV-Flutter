import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';

class PredefinedCarousel extends StatelessWidget {
  final List<Media> images;

  PredefinedCarousel({@required this.images}) : super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Carousel(
          showIndicator: false,
          overlayShadow: true,
          autoplayDuration: Duration(seconds: 5),
          animationCurve: Curves.fastOutSlowIn,
          images: images
              .map(
                (imageModel) => Hero(
                  tag: imageModel.path,
                  child: CachedNetworkImage(imageUrl: imageModel.path),
                ),
              )
              .toList()),
    );
  }
}
