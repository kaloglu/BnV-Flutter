import 'dart:async';

import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'base/base_viewmodel.dart';

class RaffleViewModel extends BaseViewModel<RaffleRepository> {
  Raffle raffle;
  var dateFormat;

  StreamController<int> ticketController = StreamController.broadcast();
  StreamController<int> enrollController = StreamController.broadcast();

  List<Ticket> tickets;

  get productImages => raffle.productInfo.images;

  get raffleTitle => raffle.title;

  get productCount => raffle.productInfo.count;

  get productUnit => raffle.productInfo.unit;

  get productName => raffle.productInfo.name;

  get productUnitPrice => raffle.productInfo.unitPrice.toStringAsFixed(2);

  get startDate => raffle.startDate;

  get endDate => raffle.endDate;

  get description => raffle.description;

  get startDateString => dateFormat.format(startDate.toDate());

  get endDateString => dateFormat.format(endDate.toDate());

  Stream<int> get ticketCount$ => ticketController.stream;

  Stream<int> get enrollCount$ => enrollController.stream;

  RaffleViewModel(RaffleRepository repository, Raffle raffle) : super() {
    assert(repository != null);
    this.repository = repository;
    assert(raffle != null);
    this.raffle = raffle;
    initializeDateFormatting("tr_TR");
    dateFormat = DateFormat(Strings.DATE_FOR_RAFFLE_DETAIL, "tr_TR");
  }

  @override
  void dispose() {
    ticketController?.close();
    enrollController?.close();
    super.dispose();
  }

  FutureOr loadAttributes(String uid) async {
    repository.getTickets(uid).listen((tickets) {
      this.tickets = tickets;
      var ticketCount = 0;
      tickets.forEach((ticket) {
        ticketCount += ticket.remain;
      });
      ticketController.add(ticketCount);
    });
    repository.getEnrolls(raffle.id, uid).listen((enrolls) {
      enrollController.add(enrolls.length);
    });
  }

  void enroll(String uid) {
    var activeTicket = tickets.first;
    repository.enroll(Enroll(ticketId: activeTicket.id, raffleId: raffle.id), uid);
  }

}
