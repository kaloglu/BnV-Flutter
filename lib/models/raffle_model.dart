import 'package:BedavaNeVar/BnvApp.dart';
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
  final DateTime startDate;
  final DateTime endDate;

  // final Timestamp startDate;
  // final Timestamp endDate;
  final RaffleRules rules;
  final ProductInfo productInfo;
  final bool isFeatured;

  const Raffle({
    Key key,
    @required this.id,
    @required this.title,
    @required this.description,
    this.startDate,
    this.endDate,
    this.rules,
    this.productInfo,
    this.isFeatured,
  }) : super(key: key);

  @override
  List<Object> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        rules,
        productInfo,
        isFeatured,
      ];

  double get durationInSec => endDate.difference(startDate).inSeconds.toDouble();

  factory Raffle.fromMap(Map<String, dynamic> data, [String documentId]) {
    if (data == null) {
      return null;
    }
    final title = data['title'] as String;
    if (title == null) {
      return null;
    }
    return Raffle(
      id: documentId ?? data['id'],
      title: title,
      description: data['description'] ?? '',
      startDate: DateTime.fromMillisecondsSinceEpoch(data['startDate'].millisecondsSinceEpoch),
      endDate: DateTime.fromMillisecondsSinceEpoch(data['endDate'].millisecondsSinceEpoch),
      // startDate: data['startDate'],
      // endDate: data['endDate'],
      rules: RaffleRules.fromMap(data['rules']),
      productInfo: ProductInfo.fromMap(data['productInfo']),
      isFeatured: data['isFeatured'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        // 'startDate': startDate,
        // 'endDate': endDate,
        'startDate': startDate.millisecondsSinceEpoch,
        'endDate': endDate.millisecondsSinceEpoch,
        'rules': rules,
        'productInfo': productInfo,
        'isFeatured': isFeatured,
      };

  factory Raffle.fromDocumentSnapshot(DocumentSnapshot docSnapshot) =>
      Raffle.fromMap(docSnapshot.data(), docSnapshot.id);

  //static List<Raffle> listFromFirestore(QuerySnapshot querySnapshot) =>
  //  querySnapshot.docs.map<Raffle>((snapshot) => Raffle.fromDocumentSnapshot(snapshot)).toList();

  get startDateReadable => Constants.readableDate(date: startDate);
  get endDateReadable => Constants.readableDate(date: endDate);
}
