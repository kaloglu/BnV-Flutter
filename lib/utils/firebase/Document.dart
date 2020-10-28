import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';

class Document<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String path;
  DocumentReference document;

  final String id;

  Document({@required this.path, this.id}) {
    document = firestore.doc(path + "/" + id);
  }

  Future<T> getData() {
    return document.get().then<T>((v) {
      return Constants.models[T](v.data);
    });
  }

  Stream<T> streamData() {
    return document.snapshots().map<T>((v) => Constants.models[T](v.data));
  }

  Future<void> upsert(Map data) {
    return document.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}
