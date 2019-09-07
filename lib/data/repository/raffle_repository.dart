import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:bnv/data/services/db/firestore_db_service.dart';
import 'package:bnv/data/services/interfaces/db_service.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/ticket_model.dart';

import 'interfaces/repository.dart';

class RaffleRepository implements Repository {
  final DBService _firestoreDb;

  DBService get firestoreDB => _firestoreDb;

  RaffleRepository({DBService db}) : _firestoreDb = db ?? FirestoreDBService();

  Stream<List<RaffleViewModel>> getRaffleViewModelList() => firestoreDB
      .getRaffles()
      .map((raffleList) => raffleList.map((raffle) => RaffleViewModel(raffle: raffle, repository: this)).toList());

  Stream<List<Ticket>> getTickets() => firestoreDB.getTickets();

  Stream<List<Enroll>> getEnrolls(raffleId) => firestoreDB.getEnrolls(raffleId);
}
