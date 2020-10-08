// import 'dart:async';
//
// import 'package:BedavaNeVar/model/attendee_model.dart';
// import 'package:BedavaNeVar/model/enroll_model.dart';
// import 'package:BedavaNeVar/model/raffle_model.dart';
// import 'package:BedavaNeVar/model/ticket_model.dart';
// import 'package:BedavaNeVar/model/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// abstract class DBService {
//   Stream<List<Attendee>> attendees(String raffleId);
//
//   void dispose();
//
//   enroll(Enroll enroll, String uid);
//
//   rewardTicket(int count, String source, String uid);
//
//   Stream<List<Enroll>> getEnrolls(String raffleId, String uid);
//
//   Stream<Raffle> getRaffle(String raffleId);
//
//   Stream<List<Raffle>> getRaffles();
//
//   Stream<List<Ticket>> getTickets(String uid);
//
//   Future<QuerySnapshot> getUnregisteredDeviceTokens(String deviceToken);
//
//   Future<User> getUser();
//
//   Stream<List<User>> getUsers();
//
//   Future<void> saveToken(String token, {String uid});
//
//   Future<void> userCreateOrUpdate(User user);
// }
