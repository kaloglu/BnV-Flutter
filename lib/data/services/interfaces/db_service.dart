import 'package:BedavaNeVar/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

export 'package:BedavaNeVar/models/models.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

abstract class DBService {
  Stream<List<Attendee>> attendees(String raffleId);

  void dispose();

  enroll(Enroll enroll, String uid);

  rewardTicket(int count, String source, String uid);

  Stream<List<Enroll>> getEnrolls(String raffleId, String uid);

  Stream<Raffle> getRaffle(String raffleId);

  Stream<List<Raffle>> getRaffles();

  Stream<List<Ticket>> getTickets(String uid);

  Future<QuerySnapshot> getUnregisteredDeviceTokens(String deviceToken);

  Future<User> getUser();

  Stream<List<User>> getUsers();

  Future<void> saveToken(String token, {String uid});

  Future<void> userCreateOrUpdate(User user);
}
