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
    this.name = '',
    this.images = const <Media>[],
    this.count = '',
    this.unit = '',
    this.unitPrice = 0.0,
  });

  @override
  List<Object> get props => [
        name,
        images,
        count,
        unit,
        unitPrice,
      ];

  factory ProductInfo.fromMap(Map<String, dynamic>? data) {
    final imgs = (data?['images'] as List?) ?? const [];
    return ProductInfo(
      name: data?['name'] as String? ?? '',
      images: imgs.map((m) => Media.fromMap(m as Map<String, dynamic>)).toList(),
      count: data?['count']?.toString() ?? '',
      unit: data?['unit']?.toString() ?? '',
      unitPrice: (data?['unitPrice'] as num?)?.toDouble() ?? 0.0,
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
