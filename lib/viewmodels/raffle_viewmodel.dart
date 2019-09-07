import 'dart:async';

import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RaffleViewModel extends ChangeNotifier {
  final Raffle _raffle;
  final RaffleRepository _repository;

  StreamController<int> ticketController = StreamController.broadcast();
  StreamController<int> enrollController = StreamController.broadcast();

  var dateFormat;

  RaffleViewModel({
    @required Raffle raffle,
    @required RaffleRepository repository,
  })
      : assert(raffle != null),
        _raffle = raffle,
        assert(repository != null),
        _repository = repository,
        super() {
    _loadAttributes();
  }


  @override
  void dispose() {
    ticketController?.close();
    enrollController?.close();
    super.dispose();
  }

  FutureOr _loadAttributes() async {
    _repository.getTickets().listen((data) {
      ticketController.add(data.length);
    });
    _repository.getEnrolls(_raffle.id).listen((data) {
      ticketController.add(data.length);
    });
  }

  List get productImages => _raffle.productInfo.images;

  get raffleTitle => _raffle.title;

  get productCount => _raffle.productInfo.count;

  get productUnit => _raffle.productInfo.unit;

  get productName => _raffle.productInfo.name;

  get productUnitPrice => _raffle.productInfo.unitPrice.toStringAsFixed(2);

  Timestamp get startDate => _raffle.startDate;

  Timestamp get endDate => _raffle.endDate;

  get description => _raffle.description;

  get startDateString => dateFormat.format(startDate.toDate());

  get endDateString => dateFormat.format(endDate.toDate());

  Stream<int> get ticketCount$ => ticketController.stream;

  Stream<int> get enrollCount$ => enrollController.stream;

}
