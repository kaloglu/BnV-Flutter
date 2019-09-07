import 'package:bnv/ui/pages/base/base_widget.dart';
import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleDetail extends StatelessWidget {
  final RaffleViewModel viewModel;
  final String userId;

  const RaffleDetail(this.viewModel, this.userId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RaffleViewModel>(
        viewModel: viewModel,
        onModelReady: (viewModel) => viewModel?.loadAttributes(userId),
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
                    buildCountLine(viewModel.ticketCount$, "<b>#</b> katılım hakkınız bulunuyor."),
                    _buildRaffleDetailButton(viewModel),
                    buildCountLine(viewModel.enrollCount$, "Bu çekilişe " + "<b>#</b> kez katıldınız."),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget buildCountLine(Stream stream, String text) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (context, snapshot) {
          int count = 0;
          if (snapshot.hasData) count = snapshot.data;
          return Html(data: text.replaceAll("#", count.toString()));
        });
  }

  Widget _buildProductionWidget(RaffleViewModel viewModel) => Container(
      color: Colors.grey,
      height: 300,
      child: GridTile(
        child: _buildImageCarousel(viewModel.productImages),
        footer: _buildInfoWidget(viewModel),
      ));

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
        title: Text(" ${viewModel.productName}", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
        trailing: Text(" Değeri: ${viewModel.productUnitPrice} ₺", style: TextStyle(color: Colors.blueGrey)),
      ));

  Widget _buildDescriptionWidget(RaffleViewModel viewModel) => Container(
        color: Colors.grey.withAlpha(30),
        padding: EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Html(data: viewModel.description),
          ],
        ),
      );

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
              viewModel.enroll(userId);
            },
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
