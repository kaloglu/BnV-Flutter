import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Enroll extends BaseModel {
  final String id;
  final String ticketId;
  final String raffleId;
  final DateTime date;

  const Enroll({super.key, this.id = '', required this.ticketId, required this.raffleId, required this.date});

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

  static Enroll fromFirestore(DocumentSnapshot doc) =>
      fromMap((doc.data() as Map<String, dynamic>?) ?? <String, dynamic>{}, doc.id);

  static Enroll fromMap(Map data, [String? documentId]) {
    final raw = data['enrollDate'];
    DateTime date;
    if (raw is int) {
      date = DateTime.fromMillisecondsSinceEpoch(raw);
    } else if (raw is Timestamp) {
      date = raw.toDate();
    } else {
      date = DateTime.now();
    }
    return Enroll(
      id: documentId ?? (data['id'] as String? ?? ''),
      ticketId: data['ticketId'] as String? ?? '',
      raffleId: data['raffleId'] as String? ?? '',
      date: date,
    );
  }

  //static List<Enroll> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
