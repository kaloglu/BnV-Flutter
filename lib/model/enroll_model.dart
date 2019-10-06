import 'package:bnv/model/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Enroll extends BaseModel {
  final String id;
  final String ticketId;
  final String raffleId;
  final Timestamp enrollDate;

  const Enroll({Key key, this.id, @required this.ticketId, @required this.raffleId, this.enrollDate}) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'ticketId': ticketId,
        'raffleId': raffleId,
        'enrollDate': enrollDate,
      };

  static Enroll fromFirestore(DocumentSnapshot doc) => fromMap(doc.data, doc.documentID);

  static Enroll fromMap(Map data, [String documentId]) => Enroll(
        id: documentId,
        ticketId: data['ticketId'] ?? '',
        raffleId: data['raffleId'] ?? '',
        enrollDate: data['enrollDate'] ?? Timestamp.now(),
      );

  static List<Enroll> listFromFirestore(QuerySnapshot query) => query.documents.map(fromFirestore).toList();
}
