import 'dart:async';

import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/viewmodels/raffle_viewmodel.dart';

import 'base/base_viewmodel.dart';

class RaffleListViewModel extends BaseViewModel<RaffleRepository> {
  StreamController<List<RaffleViewModel>> listController = StreamController.broadcast();

  get raffleList$ => listController.stream;

  @override
  void dispose() {
    listController?.close();
    super.dispose();
  }

  void load(String uid) {
    repository.getRaffleViewModelList().listen((raffleList) {
      listController.add(raffleList);
    });
  }
}
