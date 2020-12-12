import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class ProductInfo extends BaseModel {
  final String name;
  final List<Media> images;
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

  @override
  List<Object> get props => [
        name,
        images,
        count,
        unit,
        unitPrice,
      ];

  factory ProductInfo.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return ProductInfo(
      name: data['name'] ?? '',
      images: (data['images'] as List ?? []).map((media) => Media.fromMap(media)).toList(),
      count: data['count'] ?? '',
      unit: data['unit'] ?? '',
      unitPrice: data['unitPrice'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'images': images,
        'count': count,
        'unit': unit,
        'unitPrice': unitPrice,
      };
}
