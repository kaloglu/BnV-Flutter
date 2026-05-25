import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  const FirestoreService._();

  static const instance = FirestoreService._();
  static var firestoreInstance = FirebaseFirestore.instance;

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
    bool merge = false,
  }) {
    print('$path: $data');
    return firestoreInstance.doc(path).set(data, SetOptions(merge: merge));
  }

  Future<void> deleteData({@required String path}) {
    print('delete: $path');
    return firestoreInstance.doc(path).delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query) queryBuilder,
    int Function(T lhs, T rhs) sort,
  }) {
    Query query = firestoreInstance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<int> countStream({@required String path, Query Function(Query query) queryBuilder}) {
    return collectionStream(path: path, queryBuilder: queryBuilder).asyncMap((snapshots) {
      var a =  snapshots.length;
      return a;
    });
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final Stream<DocumentSnapshot> snapshots = firestoreInstance.doc(path).snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }
}
