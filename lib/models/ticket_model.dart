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
    super.key,
    required this.id,
    required this.source,
    required this.userId,
    required this.earn,
    required this.remain,
    required this.createDate,
    required this.expireDate,
    required this.lastUpdate,
  });

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

  static Ticket fromFirestore(DocumentSnapshot doc) =>
      fromMap((doc.data() as Map<String, dynamic>?) ?? <String, dynamic>{}, doc.id);

  static Ticket fromMap(Map data, [String? documentId]) {
    DateTime _toDate(dynamic v) {
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is Timestamp) return v.toDate();
      return DateTime.now();
    }
    final create = _toDate(data['createDate']);
    final expire = _toDate(data['expireDate']);
    final update = _toDate(data['lastUpdate']);
    final earn = (data['earn'] as num?)?.toInt() ?? 0;
    final remain = (data['remain'] as num?)?.toInt() ?? earn;
    return Ticket(
      id: documentId ?? (data['id'] as String? ?? ''),
      source: data['source'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      earn: earn,
      remain: remain,
      createDate: create,
      expireDate: expire,
      lastUpdate: update,
    );
  }

  //static List<Ticket> listFromFirestore(QuerySnapshot query) => query.docs.map(fromFirestore).toList();
}
