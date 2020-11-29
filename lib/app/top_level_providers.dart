import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
import 'package:BedavaNeVar/data/services/firestore_database_service.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter_riverpod/all.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';

export 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
export 'package:BedavaNeVar/data/services/firestore_database_service.dart';
export 'package:flutter_riverpod/all.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final firebaseAuthProvider = Provider<fba.FirebaseAuth>((ref) => AuthService().auth);

final authStateProvider = StreamProvider<User>((ref) {
  return ref.watch(authServiceProvider).authState;
});

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateProvider);

  var user = auth.data?.value;
  if (user.uid != null) {
    return FirestoreDatabase(uid: user.uid);
  }
  return null;
});

final loggerProvider = Provider<Logger>((ref) => Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        printEmojis: false,
      ),
    ));
