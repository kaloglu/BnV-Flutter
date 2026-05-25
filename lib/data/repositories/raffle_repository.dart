import 'package:BedavaNeVar/data/firestore_path.dart';
import 'package:BedavaNeVar/data/services/firestore_service.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class RaffleRepository {
  static const FirestoreService _service = FirestoreService.instance;

  const RaffleRepository._();

  static Future<void> createRaffle(Raffle raffle) {
    return _service.setData(path: FirestorePath.raffle(raffle.id), data: raffle.toMap());
  }

  static Future<void> removeRaffle(Raffle raffle) {
    // remove raffle
    return _service.deleteData(path: FirestorePath.raffle(raffle.id));
  }

  static Stream<Raffle> raffleStream({@required String raffleId}) {
    return _service.documentStream(
      path: FirestorePath.raffle(raffleId),
      builder: (data, documentId) => Raffle.fromMap(data, documentId),
    );
  }

  static Stream<List<Raffle>> rafflesStream() {
    return _service.collectionStream(
      path: FirestorePath.raffles(),
      builder: (data, documentId) {
        return Raffle.fromMap(data, documentId);
      },
    );
  }
}
