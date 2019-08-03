import 'package:bnv/model/raffle_model.dart';
import 'package:bnv/services/db/firestore_db_service.dart';
import 'package:bnv/services/interfaces/db_service.dart';

class RaffleRepository {
  final DBService _firestoreDb;

  RaffleRepository({DBService db}) : _firestoreDb = db ?? FirestoreDBService();

  Stream<List<Raffle>> getRaffles() => _firestoreDb.getRaffles();

//  Future<User> _signIn(Future<User> Function() signInMethod) async => await signInMethod();
//
//  Future<void> signInWithGoogle() async => await _signIn(_auth.signInWithGoogle);
//
//  Future<void> signInWithFacebook() async => await _signIn(_auth.signInWithFacebook);
//
//  Future<User> currentUser() async => await _auth.currentUser();
//
//  Future<void> signOut() async => _auth.signOut();
//
//  Future<void> saveToken() async {
//    User user = await _auth.currentUser();
//    String token = await FirebaseNotifications.getToken();
//    if (token != null) {
//      _auth.saveToken(token, uid: user.uid);
//    }
//  }
}
