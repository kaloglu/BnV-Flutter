import 'dart:async';

import 'package:bnv/model/attendee_model.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBService {
  final Firestore firestore = Firestore.instance;

  Stream<List<User>> getUsers();

  Stream<List<Raffle>> getRaffles();

  Future<QuerySnapshot> getUnregisteredDeviceTokens(String deviceToken);

  Stream<List<Attendee>> attendees(String raffleId);

  Stream<List<Enroll>> getEnrolls(String userId);

  Stream<List<Ticket>> getTickets(String userId);

  Future<User> getUser(String userId);

  Stream<Raffle> getRaffle(String raffleId);

  void dispose();

  Future<void> userCreateOrUpdate(User user);

  Future<void> saveToken(String token, { String uid});

}
