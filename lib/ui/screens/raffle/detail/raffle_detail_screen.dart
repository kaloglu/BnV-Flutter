import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:BedavaNeVar/utils/AppAds.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final raffleStreamProvider = StreamProvider.autoDispose.family<Raffle, String>((ref, raffleId) {
  final database = ref.watch(databaseProvider);
  return database?.raffleStream(raffleId: raffleId) ?? const Stream.empty();
});

class RaffleDetailScreen extends HookWidget {
  static const route = "/raffle_detail";

  final String raffleId;

  RaffleDetailScreen({Key key, this.raffleId}) : assert(raffleId != null);

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
// final canShowRewardedVideoNotifier = useState(false);
  // final rewardedVideoAd = RewardedVideoAd.instance;

  static MobileAdTargetingInfo targetInfo;

  void loadAd(RewardedVideoAd rewardedVideoAd) {
    rewardedVideoAd.load(adUnitId: AppAds.rewardedUnitId, targetingInfo: targetInfo);
  }

  void rewardTicket(int rewardAmount, String rewardType) {
    print("tebrikler $rewardAmount $rewardType hesabınıza eklendi.");
    // widget.item.reward(widget.userId, rewardAmount, rewardType);
  }

  @override
  Widget build(BuildContext context) {
    // useMemoized(
    //   () {
    //     {
    //       rewardedVideoAd = RewardedVideoAd.instance;
    //       _buildRewardedVideo();
    //     }
    //   },
    //   [rewardedVideoAd],
    // );
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(Strings.raffleDetails),
        centerTitle: true,
        actions: <Widget>[useThemeModeSwitch(context)],
      ),
      body: Center(child: RaffleDetail(raffleId)),
    );
  }

  RaffleDetailScreen.navigate(BuildContext context, this.raffleId) {
    print("page: $route");
    Navigator.pushReplacementNamed(context, route, arguments: raffleId);
  }

  static Future<void> show(BuildContext context, String raffleId) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(route, arguments: {'raffleId': raffleId});
  }
}
