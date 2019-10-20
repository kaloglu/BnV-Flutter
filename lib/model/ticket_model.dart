import 'package:bnv/model/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Ticket extends BaseModel {
  final String id;
  final String source;
  final String userId;
  final int earn;
  final int remain;
  final Timestamp createDate;
  final Timestamp expireDate;
  final Timestamp lastUpdate;

  const Ticket(
      {Key key,
      this.id,
      this.source,
      this.userId,
      this.earn,
      this.remain,
      this.createDate,
      this.expireDate,
      this.lastUpdate})
      : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'userId': userId,
        'earn': earn ?? 1,
        'remain': remain ?? earn,
        'createDate': createDate ?? Timestamp.now(),
        'expireDate': expireDate,
        'lastUpdate': lastUpdate ?? Timestamp.now(),
      };

  static Ticket fromFirestore(DocumentSnapshot doc) => fromMap(doc.data, doc.documentID);

  static Ticket fromMap(Map data, [String documentId]) => Ticket(
        id: documentId,
        source: data['source'] ?? '',
        userId: data['userId'] ?? '',
        earn: data['earn'] ?? 0,
        remain: data['remain'] ?? data['earn'] ?? 0,
        createDate: data['createDate'] ?? Timestamp.now(),
        expireDate: data['expireDate'] ?? Timestamp.now(),
        lastUpdate: data['lastUpdate'],
      );

  static List<Ticket> listFromFirestore(QuerySnapshot query) => query.documents.map(fromFirestore).toList();
}
