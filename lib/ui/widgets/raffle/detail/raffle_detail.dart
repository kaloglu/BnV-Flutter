import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/ReusableCarousel.dart';
import 'package:BedavaNeVar/utils/AppAds.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaffleDetail extends HookWidget {
  final String raffleId;

  // final canShowRewardedVideoNotifier = useState(false);
  // final rewardedVideoAd = RewardedVideoAd.instance;

  RaffleDetail(this.raffleId, {Key key}) : super(key: key);

  static MobileAdTargetingInfo targetInfo;

  // void _buildRewardedVideo() {
  //   FirebaseAdMob.instance.initialize(appId: AppAds.appId);
  //   targetInfo = MobileAdTargetingInfo(childDirected: true, keywords: ["Bedava", "Hediye", "İndirim", "Kampanya"]);
  //   rewardedVideoAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
  //     if (event == RewardedVideoAdEvent.closed) {
  //       print("$rewardAmount $rewardType için reklam kapandı");
  //       canShowRewardedVideoNotifier.value = false;
  //       loadAd(rewardedVideoAd);
  //     }
  //
  //     if (event == RewardedVideoAdEvent.started) print("$rewardAmount $rewardType için video başladı");
  //     if (event == RewardedVideoAdEvent.rewarded) rewardTicket(rewardAmount, rewardType);
  //
  //     if (event == RewardedVideoAdEvent.loaded) {
  //       print("$rewardAmount $rewardType için reklam yüklendi");
  //       canShowRewardedVideoNotifier.value = true;
  //     }
  //     if (event == RewardedVideoAdEvent.failedToLoad) print("$rewardAmount $rewardType için reklam yüklenmedi: ");
  //   };
  //
  //   loadAd(rewardedVideoAd);
  //   print("ilk yükleme");
  // }

  void loadAd(RewardedVideoAd rewardedVideoAd) {
    rewardedVideoAd.load(adUnitId: AppAds.rewardedUnitId, targetingInfo: targetInfo);
  }

  void rewardTicket(int rewardAmount, String rewardType) {
    print("tebrikler $rewardAmount $rewardType hesabınıza eklendi.");
    // widget.item.reward(widget.userId, rewardAmount, rewardType);
  }

  @override
  Widget build(BuildContext context) {
    final raffleStream = useProvider(raffleStreamProvider(raffleId));

    // useMemoized(
    //   () {
    //     {
    //       rewardedVideoAd = RewardedVideoAd.instance;
    //       _buildRewardedVideo();
    //     }
    //   },
    //   [rewardedVideoAd],
    // );
    return raffleStream.when(
      data: (raffle) {
        return ListView(
          children: <Widget>[
            _buildProductionWidget(raffle),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDescriptionWidget(raffle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildRaffleDateInfo(raffle),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  // buildTicketCountLine(raffle, "<b>#</b> katılım hakkınız bulunuyor.", CountType.TICKET),
                  // _buildRaffleDetailButton(raffle),
                  // buildTicketCountLine(raffle, "Bu çekilişe " + "<b>#</b> kez katıldınız.", CountType.ENROLL),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (object, stacktrace) {
        print(object);
        return Center(
          child: EmptyContent(
            title: 'Kampanya ekranı oluşturulurken bir hata oluştu 😲',
            message: object.toString(),
          ),
        );
      },
    );
  }

  Widget buildTicketCountLine(Raffle raffle, String text, CountType type) {
    // return StreamBuilder<int>(
    //     stream: raffle.getCount$(type),
    //     builder: (context, snapshot) {
    //       int count = 0;
    //       if (snapshot.hasData) {
    //         count = snapshot.data;
    //         raffle.setActiveCount(type, count);
    //       }
    //
    //       return Html(data: text.replaceAll("#", count.toString()));
    //     });
  }

  Widget _buildDescriptionWidget(Raffle raffle) => Container(
        color: Colors.grey.withAlpha(30),
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Html(data: raffle.description),
          ],
        ),
      );

  Widget _buildInfoWidget(Raffle raffle) => Container(
      color: Colors.white70,
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
        title: Text(
          " ${raffle.productInfo.name}",
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          Strings.currentValue + ":" + raffle.productInfo.unitPrice.toString() + " " + Strings.tlChar,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ));

  Widget _buildProductionWidget(Raffle raffle) => Container(
        color: Colors.grey,
        height: 300,
        child: GridTile(
          footer: _buildInfoWidget(raffle),
          child: _buildCarousel(raffle.productInfo.images),
        ),
      );

  Widget _buildRaffleDateInfo(Raffle raffle) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Katılım Başlangıç: "),
            ),
            Expanded(child: Html(data: "<b>${raffle.startDate}</b>")),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Çekiliş Tarihi: "),
            ),
            Expanded(child: Html(data: "<b>${raffle.endDate}</b>")),
          ],
        ),
      ],
    );
  }

  Widget _buildRaffleDetailButton(Raffle raffle) {
    // return StreamBuilder<int>(
    //   initialData: 0,
    //   stream: raffle.ticketCount$,
    //   builder: (context, snapshot) {
    //     var ticketCount = snapshot.data;
    //     if (ticketCount > 0) {
    //       return RaisedButton(
    //         child: Text("Enroll Button"),
    //         onPressed: () {
    //           raffle.enroll(widget.userId);
    //         },
    //       );
    //     } else {
    //       return RaisedButton(
    //         child: Text("Earn Button"),
    //         onPressed: (canShowRewardedVideo)
    //             ? () {
    //                 RewardedVideoAd.instance.show();
    //               }
    //             : null,
    //       );
    //     }
    //   },
    // );
  }

  Carousel _buildCarousel(List<Media> images) => Carousel(
      overlayShadow: true,
      dotBgColor: Colors.black26,
      dotSize: 4,
      indicatorBgPadding: 5.0,
      dotSpacing: 15,
      showIndicator: (images.length > 1),
      dotPosition: DotPosition.topRight,
      autoplayDuration: Duration(seconds: 5),
      animationCurve: Curves.fastOutSlowIn,
      images: images
          .map((imageModel) => Container(
                padding: EdgeInsets.only(top: 16, bottom: 24),
                child: Hero(tag: imageModel.path, child: CachedNetworkImage(imageUrl: imageModel.path)),
              ))
          .toList());
}
