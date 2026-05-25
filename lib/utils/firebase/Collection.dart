import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';

class Collection<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String path;
  late final CollectionReference<Map<String, dynamic>> collection;

  Collection({required this.path}) {
    collection = firestore.collection(path);
  }

  Future<List<T>> getData([String? id]) async => <T>[];

  Stream<List<T>> streamData() => Stream<List<T>>.value(<T>[]);
}
