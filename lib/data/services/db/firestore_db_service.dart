import 'package:bnv/data/services/interfaces/db_service.dart';
import 'package:bnv/model/attendee_model.dart';
import 'package:bnv/model/enroll_model.dart';
import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/model/ticket_model.dart';
import 'package:bnv/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBService implements DBService {
  final Firestore _firestore;

  FirestoreDBService({Firestore firestore}) : _firestore = firestore ?? Firestore.instance;

  CollectionReference get getUserCollection => _firestore.collection("users");

  CollectionReference get getRaffleCollection => _firestore.collection("raffles");

  CollectionReference get getUnRegisteredDeviceTokensCollection =>
      _firestore.collection("deviceTokens/users/unregistered");

  DocumentReference getUnregisteredToken(String token) => getUnRegisteredDeviceTokensCollection.document(token);

  DocumentReference getUserReference(String uid) => getUserCollection.document(uid);

  DocumentReference getTicketReference(String ticketId, String uid) => getTicketCollection(uid).document(ticketId);

  CollectionReference getEnrollCollection(String uid) => getUserReference(uid).collection("enrolls");

  CollectionReference getTicketCollection(String uid) =>
      getUserReference(uid).collection("tickets");

  DocumentReference getRaffleReference(String raffleId) => getRaffleCollection.document(raffleId);

  CollectionReference getAttendeeCollection(String raffleId) => getRaffleReference(raffleId).collection("attendees");

  @override
  Stream<List<User>> getUsers() => getUserCollection.snapshots().map(User.listFromFirestore);

  @override
  Future<User> getUser([userId]) async =>
      Future.value(
          User.fromFirestore(await getUserReference(userId).get())
      );

  @override
  Stream<List<Enroll>> getEnrolls(String raffleId, String uid) =>
      getEnrollCollection(uid).where("raffleId", isEqualTo: raffleId).snapshots().map(Enroll.listFromFirestore);

  @override
  Stream<List<Ticket>> getTickets(String uid) =>
      getTicketCollection(uid).where("remain", isGreaterThan: 0).snapshots().map(Ticket.listFromFirestore);

  @override
  Stream<List<Raffle>> getRaffles() => getRaffleCollection.snapshots().map(Raffle.listFromFirestore);

  @override
  Stream<Raffle> getRaffle(String raffleId) => getRaffleReference(raffleId).snapshots().map(Raffle.fromFirestore);

  @override
  Stream<List<Attendee>> attendees(String raffleId) =>
      getAttendeeCollection(raffleId).snapshots().map(Attendee.listFromFirestore);

  @override
  Future<QuerySnapshot> getUnregisteredDeviceTokens(String deviceToken) =>
      getUnRegisteredDeviceTokensCollection
          .where("deviceToken", isEqualTo: deviceToken)
          .getDocuments();

  @override
  void dispose() {}

  @override
  Future<void> userCreateOrUpdate(User user) async {
    // Check is already sign up
    final DocumentReference userRef = getUserReference(user.uid);
    _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);
      if (userSnapshot.exists) {
        await tx.update(userRef, User.fromFirestore(userSnapshot).toJson());
      } else {
        await tx.set(userRef, user.toJson());
      }
    });
  }

  @override
  enroll(Enroll enroll, String uid) {
    DocumentReference ticketRef = getTicketReference(enroll.ticketId, uid);
    _firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot ticketSnapshot = await tx.get(ticketRef);
      if (ticketSnapshot.exists) {
        Ticket ticket = Ticket.fromFirestore(ticketSnapshot);
        await tx.update(ticketRef, {
          "remain": ticket.remain - 1
        });
        await getEnrollCollection(uid).add(enroll.toJson());
        Attendee attendee = Attendee(userId: uid);
        await getAttendeeCollection(enroll.raffleId).add(attendee.toJson());
      }
    });
  }

  @override
  Future<void> saveToken(String token, { String uid = ""}) async {
    print("deviceToken => " + token);
    var deviceToken = {
      "deviceToken": token
    };
    if (uid != null && uid.isNotEmpty) {
      DocumentReference userRef = getUserReference(uid);
      _firestore.runTransaction((Transaction tx) async {
        DocumentSnapshot userSnapshot = await tx.get(userRef);
        if (userSnapshot.exists) {
          await tx.update(userRef, deviceToken);
          await getUnregisteredDeviceTokens(token).then((result) {
            result.documents.forEach((doc) {
              tx.delete(getUnregisteredToken(doc.documentID));
            });
          });
        }
      });
    } else {
      getUnregisteredDeviceTokens(token).then((result) {
        if (result.documents.length <= 0)
          getUnRegisteredDeviceTokensCollection.document().setData(deviceToken);
      });
    }
  }

}
