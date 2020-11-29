import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final raffleStreamProvider = StreamProvider.autoDispose.family<Raffle, String>((ref, raffleId) {
  final database = ref.watch(databaseProvider);
  return database?.raffleStream(raffleId: raffleId) ?? const Stream.empty();
});

class RaffleDetailScreen extends StatelessWidget {
  static const route = "/raffle_detail";

  final String raffleId;

  RaffleDetailScreen({Key key, this.raffleId}) : assert(raffleId != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(Strings.raffleDetails),
        centerTitle: true,
      ),
      body: Center(
        child: RaffleDetail(raffleId),
      ),
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
