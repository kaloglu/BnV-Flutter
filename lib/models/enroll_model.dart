import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Enroll extends BaseModel {
  final String id;
  final String ticketId;
  final String raffleId;
  final DateTime date;

  const Enroll({Key key, this.id, @required this.ticketId, @required this.raffleId, this.date}) : super(key: key);

  @override
  List<Object> get props => [
        id,
        ticketId,
        raffleId,
        date,
      ];

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'ticketId': ticketId,
        'raffleId': raffleId,
        'enrollDate': date.millisecondsSinceEpoch,
      };

  static Enroll fromFirestore(DocumentSnapshot doc) => fromMap(doc.data(), doc.id);

  static Enroll fromMap(Map data, [String documentId]) => Enroll(
        id: documentId,
        ticketId: data['ticketId'] ?? '',
        raffleId: data['raffleId'] ?? '',
        date: DateTime.fromMillisecondsSinceEpoch(data['enrollDate'] as int),
      );

  static List<Enroll> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
