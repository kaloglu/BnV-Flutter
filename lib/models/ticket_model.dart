import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Ticket extends BaseModel {
  final String id;
  final String source;
  final String userId;
  final int earn;
  final int remain;
  final DateTime createDate;
  final DateTime expireDate;
  final DateTime lastUpdate;

  const Ticket({
    Key key,
    this.id,
    this.source,
    this.userId,
    this.earn,
    this.remain,
    this.createDate,
    this.expireDate,
    this.lastUpdate,
  }) : super(key: key);

  @override
  List<Object> get props => [
        id,
        source,
        userId,
        earn,
        remain,
        createDate,
        expireDate,
        lastUpdate,
      ];

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'source': source,
        'userId': userId,
        'earn': earn ?? 1,
        'remain': remain ?? earn,
        'createDate': createDate.millisecondsSinceEpoch,
        'expireDate': expireDate.millisecondsSinceEpoch,
        'lastUpdate': lastUpdate.millisecondsSinceEpoch,
      };

  static Ticket fromFirestore(DocumentSnapshot doc) => fromMap(doc.data(), doc.id);

  static Ticket fromMap(Map data, [String documentId]) => Ticket(
        id: documentId,
        source: data['source'] ?? '',
        userId: data['userId'] ?? '',
        earn: data['earn'] ?? 0,
        remain: data['remain'] ?? data['earn'] ?? 0,
        createDate: DateTime.fromMillisecondsSinceEpoch(data['createDate'] ?? Timestamp.now() as int),
        expireDate: DateTime.fromMillisecondsSinceEpoch(data['expireDate'] as int),
        lastUpdate: DateTime.fromMillisecondsSinceEpoch(data['lastUpdate'] ?? Timestamp.now() as int),
      );

  static List<Ticket> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
