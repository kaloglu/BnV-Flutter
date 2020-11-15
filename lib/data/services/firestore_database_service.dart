import 'package:BedavaNeVar/data/services/firestore_path.dart';
import 'package:BedavaNeVar/data/services/firestore_service.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:meta/meta.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null, 'Cannot create FirestoreDatabase with null uid');
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setRaffle(Raffle raffle) => _service.setData(
        path: FirestorePath.raffle(uid, raffle.id),
        data: raffle.toMap(),
      );

  Future<void> deleteRaffle(Raffle raffle) async {
    // delete where enroll.raffleId == raffle.raffleId
    final allEnrolls = await enrollsStream(raffle: raffle).first;
    for (final enroll in allEnrolls) {
      if (enroll.raffleId == raffle.id) {
        await deleteEnroll(enroll);
      }
    }
    // delete raffle
    await _service.deleteData(path: FirestorePath.raffle(uid, raffle.id));
  }

  Stream<Raffle> raffleStream({@required String raffleId}) => _service.documentStream(
        path: FirestorePath.raffle(uid, raffleId),
        builder: (data, documentId) => Raffle.fromMap(data, documentId),
      );

  Stream<List<Raffle>> rafflesStream() => _service.collectionStream(
        path: FirestorePath.raffles(uid),
        builder: (data, documentId) => Raffle.fromMap(data, documentId),
      );

  Future<void> setEnroll(Enroll enroll) => _service.setData(
        path: FirestorePath.enroll(uid, enroll.id),
        data: enroll.toMap(),
      );

  Future<void> deleteEnroll(Enroll enroll) => _service.deleteData(path: FirestorePath.enroll(uid, enroll.id));

  Stream<List<Enroll>> enrollsStream({Raffle raffle}) => _service.collectionStream<Enroll>(
        path: FirestorePath.enrolls(uid),
        queryBuilder: raffle != null ? (query) => query.where('raffleId', isEqualTo: raffle.id) : null,
        builder: (data, documentID) => Enroll.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.date.compareTo(lhs.date),
      );
}
