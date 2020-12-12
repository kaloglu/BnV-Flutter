import 'package:BedavaNeVar/BnvApp.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/raffle/detail/raffle_detail_screen.dart';
import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:BedavaNeVar/ui/widgets/common/theme_switch.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/PredefinedCarousel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaffleDetail extends HookWidget {
  final String raffleId;

  RaffleDetail(this.raffleId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final raffleStream = useProvider(raffleStreamProvider(raffleId));

    return raffleStream.when(
      data: (raffle) {
        return ListView(
          children: <Widget>[
            _buildProductionWidget(context, raffle),
            _buildDescriptionWidget(context, raffle),
            // buildTicketCountLine(raffle, "<b>#</b> katılım hakkınız bulunuyor.", CountType.TICKET),
            // _buildRaffleDetailButton(raffle),
            // buildTicketCountLine(raffle, "Bu çekilişe " + "<b>#</b> kez katıldınız.", CountType.ENROLL),
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

  Widget _buildDescriptionWidget(BuildContext context, Raffle raffle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
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
        Column(children: [
          Container(alignment: AlignmentDirectional.topEnd, child: _buildDateInfoWidget(context, raffle)),
        ]),
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

  Widget _buildStartDateInfoWidget(BuildContext context, Raffle raffle) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Theme.of(context).cardColor.withOpacity(0.5),
            boxShadow: useShadowColors(context, blurRadius: 20),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 12.0),
          child: Text.rich(
            TextSpan(text: "Katılım: ${raffle.startDateReadable}", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildEndDateInfoWidget(BuildContext context, Raffle raffle) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Theme.of(context).cardColor.withOpacity(0.5),
            boxShadow: useShadowColors(context, blurRadius: 20),
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          margin: EdgeInsets.symmetric(vertical: 12.0),
          child: Text.rich(
            TextSpan(text: "Çekiliş: ${raffle.endDateReadable}", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  _buildDateInfoWidget(BuildContext context, Raffle raffle) =>
      (true) ? _buildStartDateInfoWidget(context, raffle) : _buildEndDateInfoWidget(context, raffle);
}
