import 'package:bnv/model/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Attendee extends BaseModel {
  final String id;
  final String userId;
  final Timestamp attendDate;

  const Attendee({Key key, this.id, @required this.userId, this.attendDate}) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'attendDate': attendDate,
      };

  static Attendee fromFirestore(DocumentSnapshot doc) => fromMap(doc.data, doc.documentID);

  static List<Attendee> listFromFirestore(QuerySnapshot query) => query.documents.map(fromFirestore).toList();

  static Attendee fromMap(Map data, [String documentId]) => Attendee(
        id: documentId,
        userId: data['userId'] ?? '',
        attendDate: data['attendDate'] ?? Timestamp.now(),
      );
}
