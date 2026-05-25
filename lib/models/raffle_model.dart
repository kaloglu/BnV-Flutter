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
  final RaffleRules? rules;
  final ProductInfo? productInfo;
  final bool isFeatured;

  const Raffle({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.rules,
    this.productInfo,
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [
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

  factory Raffle.fromMap(Map<String, dynamic>? data, [String? documentId]) {
    final map = data ?? <String, dynamic>{};
    final title = map['title'] as String? ?? '';
    final desc = map['description'] as String? ?? '';

    DateTime _toDate(dynamic v) {
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is Timestamp) return v.toDate();
      if (v is Map && v['millisecondsSinceEpoch'] is int) {
        return DateTime.fromMillisecondsSinceEpoch(v['millisecondsSinceEpoch'] as int);
      }
      return DateTime.now();
    }

    final sd = _toDate(map['startDate']);
    final ed = _toDate(map['endDate']);

    return Raffle(
      id: documentId ?? (map['id'] as String? ?? ''),
      title: title,
      description: desc,
      startDate: sd,
      endDate: ed,
      rules: RaffleRules.fromMap(map['rules'] as Map<String, dynamic>?),
      productInfo: ProductInfo.fromMap(map['productInfo'] as Map<String, dynamic>?),
      isFeatured: map['isFeatured'] as bool? ?? false,
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
        'rules': rules?.toMap(),
        'productInfo': productInfo?.toMap(),
        'isFeatured': isFeatured,
      };

  factory Raffle.fromDocumentSnapshot(DocumentSnapshot docSnapshot) =>
      Raffle.fromMap(docSnapshot.data() as Map<String, dynamic>?, docSnapshot.id);

  //static List<Raffle> listFromFirestore(QuerySnapshot querySnapshot) =>
  //  querySnapshot.docs.map<Raffle>((snapshot) => Raffle.fromDocumentSnapshot(snapshot)).toList();

  get startDateReadable => Constants.readableDate(date: startDate);
  get endDateReadable => Constants.readableDate(date: endDate);
}
