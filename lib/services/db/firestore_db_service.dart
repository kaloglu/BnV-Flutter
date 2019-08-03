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

  DocumentReference getUnregisteredToken(String token) => getUnRegisteredDeviceTokensCollection.document(token);
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
  Stream<List<Raffle>> getRaffles() {
    return getRaffleCollection.snapshots().map(Raffle.listFromFirestore);
  }

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
    firestore.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);
      if (userSnapshot.exists) {
        await tx.update(userRef, User.fromFirestore(userSnapshot).toJson());
      } else {
        await tx.set(userRef, user.toJson());
      }
    });
  }

  @override
  Future<void> saveToken(String token, { String uid = ""}) async {
    print("deviceToken:" + token);
    var deviceToken = {
      "deviceToken": token
    };
    if (uid != null && uid.isNotEmpty) {
      DocumentReference userRef = getUserReference(uid);
      firestore.runTransaction((Transaction tx) async {
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
