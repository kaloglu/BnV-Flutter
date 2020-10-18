import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/services/firebase_db_service.dart';
import 'package:BedavaNeVar/models/models.dart';

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = _db.doc(path);
  }

  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((v) => Global.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs.map((doc) => Global.models[T](doc.data) as T).toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) {
      return list.docs.map((doc) {
        return Global.models[T](doc.data) as T;
      }).toList();
    });
  }
}

class RaffleCollection {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  RaffleCollection() {
    ref = _db.collection("raffles");
  }

  Future<List<Raffle>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs.map<Raffle>((doc) => Raffle.fromMap(doc.data())).toList();
  }

  Stream<List<Raffle>> streamData() {
    return ref.snapshots().map((list) {
      return list.docs.map<Raffle>((doc) {
        return Raffle.fromMap(doc.data());
      }).toList();
    });
  }
}
