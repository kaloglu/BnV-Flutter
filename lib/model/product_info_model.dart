import 'package:bnv/model/base/base_model.dart';
import 'package:flutter/material.dart';

@immutable
class ProductInfo extends BaseModel {
  final String name;
  final List images;
  final String count;
  final String unit;
  final double unitPrice;

  const ProductInfo({
    this.name,
    this.images,
    this.count,
    this.unit,
    this.unitPrice,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'images': images,
        'count': count,
        'unit': unit,
        'unitPrice': unitPrice,
      };

  static ProductInfo fromMap(Map data) => ProductInfo(
        name: data['name'] ?? '',
        images: data['images'],
        count: data['count'] ?? '',
        unit: data['unit'] ?? '',
        unitPrice: data['unitPrice'] ?? '',
      );
}
