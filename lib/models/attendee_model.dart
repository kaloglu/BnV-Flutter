import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Attendee extends BaseModel {
  final String id;
  final String userId;
  final DateTime attendDate;

  const Attendee({Key key, this.id, @required this.userId, this.attendDate}) : super(key: key);

  @override
  List<Object> get props => [
        id,
        userId,
        attendDate,
      ];

  @override
  Map<String, dynamic> toMap() => {
        'userId': userId,
        'attendDate': attendDate.millisecondsSinceEpoch,
      };

  static Attendee fromFirestore(DocumentSnapshot doc) => fromMap(doc.data(), doc.id);

  static Attendee fromMap(Map data, [String documentId]) => Attendee(
        id: documentId,
        userId: data['userId'] ?? '',
        attendDate: DateTime.fromMillisecondsSinceEpoch(data['attendDate'] as int),
      );

  static List<Attendee> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
