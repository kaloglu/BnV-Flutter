import 'dart:async';

import 'package:bnv/viewmodels/raffle_viewmodel.dart';
import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:flutter/material.dart';

class RaffleListViewModel extends ChangeNotifier {
  final RaffleRepository _repository;

  Stream<List<RaffleViewModel>> _raffleViewModelList$;

  get viewModelList$ => _raffleViewModelList$;

  RaffleListViewModel({RaffleRepository repository})
      : _repository = repository ?? RaffleRepository(),
        super();

  void load(String uid){
    _raffleViewModelList$ = _repository.getRaffleViewModelList();
  }
}
