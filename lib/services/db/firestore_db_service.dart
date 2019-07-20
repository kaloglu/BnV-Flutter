import 'package:bnv/model/attendee_model.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:bnv/services/interfaces/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBService extends DBService {
  CollectionReference get getUserCollection => firestore.collection("users");

  CollectionReference get getRaffleCollection => firestore.collection("raffles");

  CollectionReference get getUnRegisteredDeviceTokensCollection =>
      firestore.collection("deviceTokens/users/unregistered");

  DocumentReference getUserReference(String userId) => getUserCollection.document(userId);

  CollectionReference getEnrollCollection(String userId) => getUserReference(userId).collection("enrolls");

  CollectionReference getTicketCollection(String userId) => getUserReference(userId).collection("tickets");

  DocumentReference getRaffleReference(String raffleId) => getRaffleCollection.document(raffleId);

  CollectionReference getAttendeeCollection(String raffleId) => getRaffleReference(raffleId).collection("attendees");

  @override
  Stream<List<User>> getUsers() => getUserCollection.snapshots().map(User.listFromFirestore);

  @override
  Stream<User> getUser(String userId) => getUserReference(userId).snapshots().map(User.fromFirestore);

  @override
  Stream<List<Enroll>> getEnrolls(String userId) =>
      getEnrollCollection(userId).snapshots().map(Enroll.listFromFirestore);

  @override
  Stream<List<Ticket>> getTickets(String userId) =>
      getTicketCollection(userId).snapshots().map(Ticket.listFromFirestore);

  @override
  Stream<List<Raffle>> getRaffles() => getRaffleCollection.snapshots().map(Raffle.listFromFirestore);

  @override
  Stream<Raffle> getRaffle(String raffleId) => getRaffleReference(raffleId).snapshots().map(Raffle.fromFirestore);

  @override
  Stream<List<Attendee>> attendees(String raffleId) =>
      getAttendeeCollection(raffleId).snapshots().map(Attendee.listFromFirestore);

  @override
  Stream<List<String>> getUnregisteredDeviceTokens() => getUnRegisteredDeviceTokensCollection
      .snapshots()
      .map((list) => list.documents.map((doc) => doc.data['deviceToken']).toList());

  @override
  void dispose() {}
}
