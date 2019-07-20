import 'package:bnv/model/attendee_model.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/db/firestore_db_service.dart';
import 'package:bnv/services/interfaces/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum DBServiceType { firebase }

class DBServiceAdapter implements DBService {
  DBServiceAdapter() {
    _setup();
  }

  final FirestoreDBService _firebaseDBService = FirestoreDBService();

  DBService get dbService => _firebaseDBService;

  @override
  Firestore get firestore => _firebaseDBService.firestore;

  @override
  Stream<List<Attendee>> attendees(String raffleId) => _firebaseDBService.attendees(raffleId);

  @override
  Stream<List<Enroll>> getEnrolls(String userId) => _firebaseDBService.getEnrolls(userId);

  @override
  Stream<Raffle> getRaffle(String raffleId) => _firebaseDBService.getRaffle(raffleId);

  @override
  Stream<List<Raffle>> getRaffles() => _firebaseDBService.getRaffles();

  @override
  Stream<List<Ticket>> getTickets(String userId) => _firebaseDBService.getTickets(userId);

  @override
  Stream<List<String>> getUnregisteredDeviceTokens() => _firebaseDBService.getUnregisteredDeviceTokens();

  @override
  Stream<User> getUser(String userId) => _firebaseDBService.getUser(userId);

  @override
  Stream<List<User>> getUsers() => _firebaseDBService.getUsers();

  @override
  void dispose() {}

  void _setup() {}
}
