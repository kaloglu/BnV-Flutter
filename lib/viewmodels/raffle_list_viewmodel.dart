import 'dart:async';

import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/data/services/firebase_db_service.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';

import 'base/base_viewmodel.dart';

class RaffleListViewModel extends BaseViewModel<RaffleRepository> {
  StreamController<List<RaffleViewModel>> listController = StreamController.broadcast();

  CollectionReference get getRaffleCollection => FirebaseFirestore.instance.collection("raffles");

  RaffleListViewModel() : super(RaffleRepository());

  @override
  void dispose() {
    listController?.close();
    super.dispose();
  }

  void load() {}

  Stream<List<RaffleViewModel>> getRaffleListViewModel() {
    return repository.getRaffles().map<List<RaffleViewModel>>((list) {
      return list.map<RaffleViewModel>((raffle) {
        return RaffleViewModel(raffle);
      }).toList();
    });
  }
}
