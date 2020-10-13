import 'package:BedavaNeVar/data/services/db/firestore_db_service.dart';
import 'package:BedavaNeVar/data/services/interfaces/db_service.dart';
import 'package:BedavaNeVar/models/enroll_model.dart';
import 'package:BedavaNeVar/models/ticket_model.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';

import 'interfaces/repository.dart';

class RaffleRepository implements Repository {
  final DBService _firestoreDb;

  RaffleRepository({DBService db}) : _firestoreDb = db ?? FirestoreDBService();

  DBService get firestoreDB => _firestoreDb;

  void enroll(Enroll enroll, String uid) => firestoreDB.enroll(enroll, uid);

  void rewardTicket(int count, String source, String uid) => firestoreDB.rewardTicket(count, source, uid);

  Stream<List<Enroll>> getEnrolls(String raffleId, String uid) => firestoreDB.getEnrolls(raffleId, uid);

  Stream<List<RaffleViewModel>> getRaffleViewModelList() =>
      firestoreDB.getRaffles().map((raffleList) => raffleList.map((raffle) => RaffleViewModel(this, raffle)).toList());

  Stream<List<Ticket>> getTickets(String uid) => firestoreDB.getTickets(uid);
}
