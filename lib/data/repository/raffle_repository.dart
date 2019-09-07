import 'package:bnv/data/services/db/firestore_db_service.dart';
import 'package:bnv/data/services/interfaces/db_service.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/viewmodels/raffle_viewmodel.dart';

import 'interfaces/repository.dart';

class RaffleRepository implements Repository {
  final DBService _firestoreDb;

  DBService get firestoreDB => _firestoreDb;

  RaffleRepository({DBService db}) : _firestoreDb = db ?? FirestoreDBService();

  Stream<List<RaffleViewModel>> getRaffleViewModelList() => firestoreDB
      .getRaffles()
      .map((raffleList) => raffleList.map((raffle) => RaffleViewModel(this, raffle)).toList());

  Stream<List<Ticket>> getTickets(String uid) => firestoreDB.getTickets(uid);

  Stream<List<Enroll>> getEnrolls(String raffleId,String uid) => firestoreDB.getEnrolls(raffleId,uid);

  void enroll(Enroll enroll, String uid) => firestoreDB.enroll(enroll,uid);
}
