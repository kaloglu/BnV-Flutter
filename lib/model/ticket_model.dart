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
        'earn': earn,
        'remain': remain,
        'createDate': createDate,
        'expireDate': expireDate,
        'lastUpdate': lastUpdate,
      };

  static Ticket fromFirestore(DocumentSnapshot doc) => fromMap(doc.data, doc.documentID);

  static List<Ticket> listFromFirestore(QuerySnapshot query) => query.documents.map(fromFirestore).toList();

  static Ticket fromMap(Map data, [String documentId]) => Ticket(
        id: documentId,
        source: data['source'] ?? '',
        userId: data['userId'] ?? '',
        earn: data['earn'] ?? 0,
        remain: data['remain'] ?? 0,
        createDate: data['createDate'] ?? Timestamp.now(),
        expireDate: data['expireDate'] ?? Timestamp.now(),
        lastUpdate: data['lastUpdate'],
      );
}