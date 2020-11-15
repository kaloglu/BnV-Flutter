import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
import 'package:BedavaNeVar/data/services/firestore_database_service.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:logger/logger.dart';

export 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
export 'package:BedavaNeVar/data/services/firestore_database_service.dart';
export 'package:flutter_riverpod/all.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User>((ref) => ref.watch(authServiceProvider).authState);

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  final auth = ref.watch(authStateProvider);

  if (auth.data?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.data?.value?.uid);
  }
  return null;
});

final loggerProvider = Provider<Logger>((ref) => Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        printEmojis: false,
      ),
    ));
