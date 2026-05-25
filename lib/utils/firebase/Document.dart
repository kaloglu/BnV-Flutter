import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';

class Document<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String path;
  late final DocumentReference document;

  final String id;

  Document({required this.path, required this.id}) {
    document = firestore.doc('$path/$id');
  }

  Future<T?> getData() {
    return document.get().then((v) {
      final data = v.data() as Map<String, dynamic>?;
      if (data == null) return null;
      return Constants.models[T](data) as T?;
    });
  }

  Stream<T?> streamData() {
    return document.snapshots().map((v) {
      final data = v.data() as Map<String, dynamic>?;
      if (data == null) return null;
      return Constants.models[T](data) as T?;
    });
  }

  Future<void> upsert(Map data) {
    return document.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}
