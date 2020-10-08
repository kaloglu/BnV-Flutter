import 'package:BedavaNeVar/model/base/base_model.dart';
import 'package:BedavaNeVar/model/product_info_model.dart';
import 'package:BedavaNeVar/model/raffle_rules_model.dart';
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

  const Raffle({
    Key key,
    this.id,
    @required this.title,
    @required this.description,
    this.startDate,
    this.endDate,
    this.rules,
    this.productInfo,
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'rules': rules,
        'productInfo': productInfo,
      };

  static Raffle fromFirestore(DocumentSnapshot doc) => fromMap(doc.data(), doc.documentID);

  static Raffle fromMap(Map data, [String documentId]) {
    return new Raffle(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      startDate: data['startDate'],
      endDate: data['endDate'],
      rules: RaffleRules.fromMap(data['rules']),
      productInfo: ProductInfo.fromMap(data['productInfo']),
    );
  }

  static List<Raffle> listFromFirestore(QuerySnapshot query) => query.documents.map(fromFirestore).toList();
}
