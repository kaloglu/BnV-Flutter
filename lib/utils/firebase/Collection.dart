import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';

class Collection<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String path;
  CollectionReference collection;

  Collection({this.path}) {
    collection = firestore.collection(path);
  }

  Future<List<T>> getData([String id]) async {
    var snapshots = await collection.get();
    return snapshots.docs.map<T>((doc) => Constants.models[T](doc.data) as T).toList();
  }

  Stream<List<T>> streamData() {
    return collection.snapshots().map((list) {
      return list.docs.map<T>((doc) => Constants.models[T](doc.data) as T).toList();
    });
  }
}
