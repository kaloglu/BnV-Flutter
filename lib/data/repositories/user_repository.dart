import 'package:BedavaNeVar/data/firestore_path.dart';
import 'package:BedavaNeVar/data/services/firestore_service.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class UserRepository {
  static const FirestoreService _service = FirestoreService.instance;
  final String uid;

  const UserRepository(this.uid);

  @late
  Future<void> setEnroll(Enroll enroll) {
    return _service.setData(
      path: FirestorePath.enroll(uid, enroll.id),
      data: enroll.toMap(),
    );
  }

  @late
  Future<void> deleteEnroll(Enroll enroll) =>
      _service.deleteData(path: FirestorePath.enroll(uid, enroll.id));

  @late
  Stream<List<Enroll>> enrollsStream([String raffleId]) {
    return _service.collectionStream<Enroll>(
      path: FirestorePath.enrolls(uid),
      queryBuilder: (query) =>
          raffleId != null ? query.where('raffleId', isEqualTo: raffleId) : null,
      builder: (data, documentID) => Enroll.fromMap(data, documentID),
      sort: (lhs, rhs) => rhs.date.compareTo(lhs.date),
    );
  }

  @late
  Stream<int> ticketCount([String raffleId]) {
    return _service.countStream(path: FirestorePath.tickets(uid));
  }

  @late
  Stream<int> enrollCount([String raffleId]) {
    if (uid == null) return null;
    return _service.countStream(
      path: FirestorePath.enrolls(uid),
      queryBuilder: (query) =>
      raffleId != null ? query.where('raffleId', isEqualTo: raffleId) : null,
    );
  }
}
