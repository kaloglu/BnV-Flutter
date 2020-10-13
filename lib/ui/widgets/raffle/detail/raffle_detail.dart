import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/ui/screens/base/base_widget.dart';
import 'package:BedavaNeVar/utils/AppAds.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleDetail extends StatefulWidget {
  final RaffleViewModel viewModel;
  final String userId;

  const RaffleDetail(this.viewModel, this.userId, {Key key}) : super(key: key);

  @override
  _RaffleDetailState createState() => _RaffleDetailState();
}

class _RaffleDetailState extends State<RaffleDetail> {
  static MobileAdTargetingInfo targetInfo;
  static bool canShowRewardedVideo = false;
  var rewardedVideoAd = RewardedVideoAd.instance;

  @override
  void initState() {
    rewardedVideoAd = RewardedVideoAd.instance;
    _buildRewardedVideo();
    super.initState();
  }

  void _buildRewardedVideo() {
    FirebaseAdMob.instance.initialize(appId: AppAds.appId);
    targetInfo = MobileAdTargetingInfo(childDirected: true, keywords: widget.viewModel.raffleDescription.split(" "));
    rewardedVideoAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.closed) {
        print("$rewardAmount $rewardType için reklam kapandı");
        setState(() {
          canShowRewardedVideo = false;
        });
        loadAd(rewardedVideoAd);
      }

      if (event == RewardedVideoAdEvent.started) print("$rewardAmount $rewardType için video başladı");
      if (event == RewardedVideoAdEvent.rewarded) rewardTicket(rewardAmount, rewardType);

      if (event == RewardedVideoAdEvent.loaded) {
        print("$rewardAmount $rewardType için reklam yüklendi");
        setState(() {
          canShowRewardedVideo = true;
        });
      }
      if (event == RewardedVideoAdEvent.failedToLoad) print("$rewardAmount $rewardType için reklam yüklenmedi: ");
    };

    loadAd(rewardedVideoAd);
    print("ilk yükleme");
  }

  void loadAd(RewardedVideoAd rewardedVideoAd) {
    rewardedVideoAd.load(adUnitId: AppAds.rewardedUnitId, targetingInfo: targetInfo);
  }

  void rewardTicket(int rewardAmount, String rewardType) {
    print("tebrikler $rewardAmount $rewardType hesabınıza eklendi.");
    widget.viewModel.reward(widget.userId, rewardAmount, rewardType);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RaffleViewModel>(
        viewModel: widget.viewModel,
        onModelReady: (viewModel) => viewModel?.loadAttributes(widget.userId),
        builder: (context, viewModel, child) {
          return ListView(
            children: <Widget>[
              _buildProductionWidget(viewModel),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildDescriptionWidget(viewModel),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    _buildRaffleDateInfo(viewModel),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                    buildTicketCountLine(viewModel, "<b>#</b> katılım hakkınız bulunuyor.", CountType.TICKET),
                    _buildRaffleDetailButton(viewModel),
                    buildTicketCountLine(viewModel, "Bu çekilişe " + "<b>#</b> kez katıldınız.", CountType.ENROLL),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget buildTicketCountLine(RaffleViewModel viewModel, String text, CountType type) {
    return StreamBuilder<int>(
        stream: viewModel.getCount$(type),
        builder: (context, snapshot) {
          int count = 0;
          if (snapshot.hasData) {
            count = snapshot.data;
            viewModel.setActiveCount(type, count);
          }

          return Html(data: text.replaceAll("#", count.toString()));
        });
  }

  Widget _buildDescriptionWidget(RaffleViewModel viewModel) => Container(
        color: Colors.grey.withAlpha(30),
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Html(data: viewModel.raffleDescription),
          ],
        ),
      );

  Widget _buildImageCarousel(List images) => Carousel(
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
                child: CachedNetworkImage(imageUrl: imageModel['path']),
              ))
          .toList());

  Widget _buildInfoWidget(RaffleViewModel viewModel) => Container(
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
          " ${viewModel.productName}",
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          Strings.currentValue + ":" + viewModel.productUnitPrice + " " + Strings.tlChar,
          style: TextStyle(color: Colors.blueGrey),
        ),
      ));

  Widget _buildProductionWidget(RaffleViewModel viewModel) => Container(
      color: Colors.grey,
      height: 300,
      child: GridTile(
        child: _buildImageCarousel(viewModel.productImages),
        footer: _buildInfoWidget(viewModel),
      ));

  Widget _buildRaffleDateInfo(RaffleViewModel viewModel) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Katılım Başlangıç: "),
            ),
            Expanded(child: Html(data: "<b>${viewModel.startDateString}</b>")),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Çekiliş Tarihi: "),
            ),
            Expanded(child: Html(data: "<b>${viewModel.endDateString}</b>")),
          ],
        ),
      ],
    );
  }

  Widget _buildRaffleDetailButton(RaffleViewModel viewModel) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: viewModel.ticketCount$,
      builder: (context, snapshot) {
        var ticketCount = snapshot.data;
        if (ticketCount > 0) {
          return RaisedButton(
            child: Text("Enroll Button"),
            onPressed: () {
              viewModel.enroll(widget.userId);
            },
          );
        } else {
          return RaisedButton(
            child: Text("Earn Button"),
            onPressed: (canShowRewardedVideo)
                ? () {
                    RewardedVideoAd.instance.show();
                  }
                : null,
          );
        }
      },
    );
  }
}
