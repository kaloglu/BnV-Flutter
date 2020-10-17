import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:BedavaNeVar/models/product_info_model.dart';
import 'package:BedavaNeVar/models/raffle_rules_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Raffle extends BaseModel {
  final String id;
  final String title;
  final String description;
  final Timestamp startDate;
  final Timestamp endDate;
  final RaffleRules rules;
  final ProductInfo productInfo;
  final bool isFeatured;

  const Raffle({
    Key key,
    this.id,
    @required this.title,
    @required this.description,
    this.startDate,
    this.endDate,
    this.rules,
    this.productInfo,
    this.isFeatured,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'rules': rules,
        'productInfo': productInfo,
        'isFeatured': isFeatured,
      };

  static Raffle fromFirestore(DocumentSnapshot doc) => fromMap(doc.data(), doc.id);

  static Raffle fromMap(Map data, [String documentId]) {
    return new Raffle(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      startDate: data['startDate'],
      endDate: data['endDate'],
      rules: RaffleRules.fromMap(data['rules']),
      productInfo: ProductInfo.fromMap(data['productInfo']),
      isFeatured: data['isFeatured'] ?? false,
    );
  }

  static List<Raffle> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
