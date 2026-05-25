import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final raffleStreamProvider = StreamProvider.autoDispose.family<Raffle, String>(
  (ref, raffleId) => RaffleRepository.raffleStream(raffleId: raffleId) ?? const Stream.empty(),
);

class RaffleDetailScreen extends HookWidget {
  static const route = "/raffle_detail";

  final String raffleId;

  // Reklam entegrasyonu geçici olarak kaldırıldı
  // static MobileAdTargetingInfo targetInfo;

  RaffleDetailScreen({super.key, required this.raffleId});

  RaffleDetailScreen.navigate(BuildContext context, this.raffleId) {
    debugPrint('page: $route');
    Navigator.pushReplacementNamed(context, route, arguments: {'raffleId': raffleId});
  }

  RaffleDetailScreen.show(BuildContext context, this.raffleId) {
    Navigator.of(context, rootNavigator: true).pushNamed(route, arguments: {'raffleId': raffleId});
  }

  // void loadAd(RewardedVideoAd rewardedVideoAd) {}

  void rewardTicket(int rewardAmount, String rewardType) {
    debugPrint('tebrikler $rewardAmount $rewardType hesabınıza eklendi.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(Strings.raffleDetails),
        centerTitle: true,
        actions: const <Widget>[ThemeModeSwitch()],
      ),
      body: Center(child: RaffleDetail(raffleId)),
    );
  }
}
