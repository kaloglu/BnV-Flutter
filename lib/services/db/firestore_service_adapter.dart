import 'dart:async';

import 'package:bnv/model/attendee_model.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/db/firestore_db_service.dart';
import 'package:bnv/services/interfaces/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum DBServiceType { firestore }

class DBServiceAdapter implements DBService {
  DBServiceAdapter() {
    _setup();
  }

  final FirestoreDBService _firestoreDBService = FirestoreDBService();

  DBService get dbService => _firestoreDBService;

  @override
  Firestore get firestore => _firestoreDBService.firestore;

  @override
  Stream<List<Attendee>> attendees(String raffleId) => _firestoreDBService.attendees(raffleId);

  @override
  Stream<List<Enroll>> getEnrolls(String userId) => _firestoreDBService.getEnrolls(userId);

  @override
  Stream<Raffle> getRaffle(String raffleId) => _firestoreDBService.getRaffle(raffleId);

  @override
  Stream<List<Raffle>> getRaffles() => _firestoreDBService.getRaffles();

  @override
  Stream<List<Ticket>> getTickets(String userId) => _firestoreDBService.getTickets(userId);

  @override
  Future<QuerySnapshot> getUnregisteredDeviceTokens(String deviceToken) => _firestoreDBService.getUnregisteredDeviceTokens(deviceToken);

  @override
  Stream<User> getUser(String userId) => _firestoreDBService.getUser(userId);

  @override
  Stream<List<User>> getUsers() => _firestoreDBService.getUsers();

  @override
  void dispose() {
  }

  void _setup() {}

  @override
  Future<void> userCreateOrUpdate(User user) => _firestoreDBService.userCreateOrUpdate(user);

  Future<void> saveToken(String token, {String uid}) => _firestoreDBService.saveToken(token, uid: uid);

}
