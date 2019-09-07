import 'package:bnv/utils/page_navigator.dart';
import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleDetailPage extends StatelessWidget {
  static const route = "raffle_detail";

  final RaffleViewModel raffleBloc;

  RaffleDetailPage({Key key, this.raffleBloc})
      : assert(raffleBloc != null);

  static void navigate(BuildContext context, RaffleViewModel raffleBloc) =>
      PageNavigator.navigate<RaffleViewModel>(context, route, argument: raffleBloc);


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Html(data: raffleBloc.raffleTitle)), body: buildPageWidget(context));
  }

  Widget buildPageWidget(context) =>
      Center(
        child: ListView(
          children: <Widget>[
            _buildProductionWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildDescriptionWidget(),
            ),
            _buildRaffleState(),
          ],
        ),
      );

  Widget _buildRaffleState() =>
      Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildRaffleDateInfo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Html(data: "<b>${raffleBloc.ticketCount$}</b> katılım hakkınız bulunuyor."),
                  _buildRaffleDetailButton(),
                  Html(data: "Bu çekilişe <b>${raffleBloc.enrollCount$}</b> kez katıldınız."),
                ],
              ),
      );

  Widget _buildProductionWidget() =>
      Container(
          color: Colors.grey,
          height: 300,
          child: GridTile(
            child: _buildImageCarousel(raffleBloc.productImages),
            footer: _buildInfoWidget(),
          ));

  Widget _buildImageCarousel(List images) =>
      Carousel(
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
              .map((imageModel) =>
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 24),
                child: CachedNetworkImage(imageUrl: imageModel['path']),
              ))
              .toList());

  Widget _buildInfoWidget() =>
      Container(
          color: Colors.white70,
          child: ListTile(
            leading: Center(
              widthFactor: 1,
              child: Text(
                "${raffleBloc.productCount}  ${raffleBloc.productUnit}",
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(" ${raffleBloc.productName}",
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
            trailing: Text(
                " Değeri: ${raffleBloc.productUnitPrice} ₺", style: TextStyle(color: Colors.blueGrey)),
          ));

  Widget _buildDescriptionWidget() =>
      Container(
        color: Colors.grey.withAlpha(30),
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Html(data: raffleBloc.description),
          ],
        ),
      );

  Widget _buildRaffleDateInfo() {

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Katılım Başlangıç: "),
            ),
            Expanded(child: Html(data: "<b>${raffleBloc.startDateString}</b>")),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Row(
          children: <Widget>[
            Expanded(
              child: Text("Çekiliş Tarihi: "),
            ),
            Expanded(child: Html(data: "<b>${raffleBloc.endDateString}</b>")),
          ],
        ),
      ],
    );
  }

  Widget _buildRaffleDetailButton() {
    return StreamBuilder<int>(
      initialData: 0,
      stream: raffleBloc.ticketCount$,
      builder: (context, snapshot) {
        var ticketCount = snapshot.data;
        if (ticketCount > 0) {
          return RaisedButton(
            child: Text("Enroll Button"),
            onPressed: () {},
          );
        } else {
          return RaisedButton(
            child: Text("Earn Button"),
            onPressed: null,
          );
        }
      },
    );
  }

}
