import 'dart:async';

import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:bnv/viewmodels/raffle_viewmodel.dart';

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
