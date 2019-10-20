import 'dart:async';

import 'package:bnv/constants/strings.dart';
import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/ui/widgets/raffle_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'base/base_viewmodel.dart';

class RaffleViewModel extends BaseViewModel<RaffleRepository> {
  Raffle raffle;
  var dateFormat;
  int activeTicketCount;
  int activeEnrollCount;

  StreamController<int> ticketController = StreamController.broadcast();
  StreamController<int> enrollController = StreamController.broadcast();

  List<Ticket> tickets;

  RaffleViewModel(RaffleRepository repository, Raffle raffle) : super() {
    assert(repository != null);
    this.repository = repository;
    assert(raffle != null);
    this.raffle = raffle;
    initializeDateFormatting("tr_TR");
    dateFormat = DateFormat(Strings.DATE_FOR_RAFFLE_DETAIL, "tr_TR");
  }

  Stream<int> get enrollCount$ => enrollController.stream;

  Stream<int> get ticketCount$ => ticketController.stream;

  Timestamp get endDate => raffle.endDate;

  Timestamp get startDate => raffle.startDate;

  List get productImages => raffle.productInfo.images;

  String get endDateString => dateFormat.format(endDate.toDate());

  String get startDateString => dateFormat.format(startDate.toDate());

  String get raffleDescription => raffle.description;

  String get productCount => raffle.productInfo.count;

  String get productName => raffle.productInfo.name;

  String get productUnit => raffle.productInfo.unit;

  String get productUnitPrice => raffle.productInfo.unitPrice.toStringAsFixed(2);

  String get raffleTitle => raffle.title;

  @override
  void dispose() {
    ticketController?.close();
    enrollController?.close();
    super.dispose();
  }

  Stream<int> getCount$(CountType type) {
    if (type == CountType.TICKET)
      return ticketCount$;
    else
      return enrollCount$;
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

  void setActiveCount(CountType type, int count) {
    if (type == CountType.TICKET)
      activeTicketCount = count;
    else
      activeEnrollCount = count;
  }

  void enroll(String uid) {
    var activeTicket = tickets.first;
    ticketController.add(activeTicketCount - 1);
    enrollController.add(activeEnrollCount + 1);
    repository.enroll(Enroll(ticketId: activeTicket.id, raffleId: raffle.id), uid);
  }

  void reward(String uid, int rewardAmount, String rewardType) {
    repository.rewardTicket(rewardAmount,rewardType, uid);
  }
}
