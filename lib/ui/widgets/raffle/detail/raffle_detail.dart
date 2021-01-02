import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/constants/variables.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/auth/auth_widget.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:BedavaNeVar/ui/widgets/common/notch.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/PredefinedCarousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ticketCountProvider = StreamProvider.autoDispose<int>(
    (ref) => ref.watch(userRepositoryProvider)?.ticketCount());
final enrollCountProvider = StreamProvider.autoDispose<int>(
    (ref) => ref.watch(userRepositoryProvider)?.enrollCount());

class RaffleDetail extends HookWidget {
  final String raffleId;

  RaffleDetail(this.raffleId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activeTicketCount = useState(0);
    var activeEnrollCount = useState(0);
    var ticketProvider = useProvider(ticketCountProvider);
    var enrollProvider = useProvider(enrollCountProvider);

    useEffect(
      () {
        ticketProvider?.when(
          data: (ticketCount) => activeTicketCount.value = ticketCount,
          loading: () => activeTicketCount.value = -2,
          error: (error, stackTrace) => activeTicketCount.value = -1,
        );

        enrollProvider?.when(
          data: (enrollCount) => activeEnrollCount.value = enrollCount,
          loading: () => activeEnrollCount.value = -2,
          error: (error, stackTrace) => activeEnrollCount.value = -1,
        );

        return;
      },
      [ticketProvider,enrollProvider],
    );



    final raffleStream = useProvider(raffleStreamProvider(raffleId));

    return raffleStream.when(
      data: (raffle) {
        return ListView(
          children: <Widget>[
            _buildProductionWidget(context, raffle),
            _buildDescriptionWidget(context, raffle),
            // _buildTicketCountLine(activeTicketCount.value.toString()),
            // _buildRaffleDetailButton(raffle),
            _buildEnrollCountLine(context, activeEnrollCount.value.toString()),
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

  Widget _buildTicketCountLine(String count) =>
      _buildCountLine(Strings.ticketCountText, count);

  Widget _buildEnrollCountLine(BuildContext context, String count) => AuthWidget(
    nonSignedIn: (context) => Text("Test"),
    signedIn:(context) =>  Notch(
          child: Row(
            children: [
              Icon(FontAwesomeIcons.ticketAlt),
              Padding(
                padding: EdgeInsets.all(1.0),
              ),
              Text(count),
            ],
          ),
          position: NotchPosition.centerRight(),
          margin: EdgeInsets.symmetric(vertical: 20.0),
          color: Theme.of(context).cardColor,
        ),
  );

  // Padding(
  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
  //   child: _buildCountLine(Strings.enrollCountText, count),
  // );

  Html _buildCountLine(String text, String count) =>
      Html(data: text.replaceAll(Variables.count, count));

  Widget _buildDescriptionWidget(BuildContext context, Raffle raffle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Theme.of(context).cardColor,
        boxShadow: useShadowColors(context, blurRadius: 20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Html(data: raffle.description),
    );
  }

  Widget _buildProductionWidget(BuildContext context, Raffle raffle) {
    return Stack(
      children: [
        Hero(tag: raffle.title, child: PredefinedCarousel(raffle: raffle)),
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

  Widget _buildEndDateInfoWidget(BuildContext context, Raffle raffle) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Theme.of(context).cardColor.withOpacity(0.5),
            boxShadow: useShadowColors(context, blurRadius: 20),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 12.0),
          child: Text.rich(
            TextSpan(
                text: "Çekiliş: ${raffle.endDateReadable}",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfoWidget(BuildContext context, Raffle raffle) {
    return Text.rich(
      TextSpan(
        text: (true)
            ? "Katılım: ${raffle.startDateReadable}"
            : "Çekiliş: ${raffle.endDateReadable}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
