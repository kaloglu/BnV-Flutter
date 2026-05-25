import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Attendee extends BaseModel {
  final String id;
  final String userId;
  final DateTime? attendDate;

  const Attendee({super.key, this.id = '', required this.userId, DateTime? this.attendDate});

  static Attendee fromFirestore(DocumentSnapshot doc) =>
      fromMap((doc.data() as Map<String, dynamic>?) ?? <String, dynamic>{}, doc.id);

  static Attendee fromMap(Map data, [String? documentId]) {
    final raw = data['attendDate'];
    DateTime? attend;
    if (raw is int) {
      attend = DateTime.fromMillisecondsSinceEpoch(raw);
    } else if (raw is Timestamp) {
      attend = raw.toDate();
    }
    return Attendee(
      id: documentId ?? (data['id'] as String? ?? ''),
      userId: data['userId'] as String? ?? '',
      attendDate: attend,
    );
  }

  //static List<Attendee> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
