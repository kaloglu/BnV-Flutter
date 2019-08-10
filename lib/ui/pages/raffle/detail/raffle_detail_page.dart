import 'package:bnv/model/product_info_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RaffleDetailPage extends StatelessWidget {
  final Raffle raffle;

  RaffleDetailPage({Key key, this.raffle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Html(data: raffle.title),),
        body: _buildRaffleWidget()
    );
  }

  Widget _buildRaffleWidget() =>
      ListView(
        children: <Widget>[
          _buildImageListWidget(raffle.productInfo),
          _buildDescriptionWidget(),
        ],
      );

  Widget _buildDescriptionWidget() =>
      GridTile(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Html(data: raffle.description),
            ],
          ),
        ),
      );

  Widget _buildImageListWidget(ProductInfo product) =>
      Container(
          color: Colors.grey,
          height: 300,
          child: GridTile(
            child: _buildImageCarousel(product.images),
            footer: _buildImageFooterWidget(raffle.productInfo),
          )
      );

  Widget _buildImageCarousel(List images) {
    return Carousel(
        overlayShadow: true,
        dotBgColor: Colors.black26,
        dotSize: 4,
        indicatorBgPadding: 5.0,
        dotSpacing: 15,
        showIndicator: (images.length > 1),
        dotPosition: DotPosition.topRight,
        autoplayDuration: Duration(seconds: 5),
        animationCurve: Curves.fastOutSlowIn,
        images: images.map((imageModel) =>
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 24),
              child: CachedNetworkImage(
                  imageUrl: imageModel['path']),
            )
        ).toList()
    );
  }

  Widget _buildImageFooterWidget(ProductInfo product) =>
      Container(
          color: Colors.white70,
          child: ListTile(
            leading: Center(
              widthFactor: 1,
              child: Text(
                "${product.count}  ${product.unit}",
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            ),
            title: Text(
                " ${product.name}",
                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)
            ),
            trailing: Text(
                " Değeri: ${product.unitPrice.toStringAsFixed(2)} ₺",
                style: TextStyle(color: Colors.blueGrey)
            ),
          )
      );

}
