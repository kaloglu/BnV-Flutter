import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/data/repositories/user_repository.dart';
import 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
import 'package:BedavaNeVar/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter_riverpod/all.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';

export 'package:BedavaNeVar/data/repositories/user_repository.dart';
export 'package:BedavaNeVar/data/services/firebase_auth_service.dart';
export 'package:flutter_riverpod/all.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final firebaseAuthProvider = Provider<fba.FirebaseAuth>((ref) => AuthService().auth);

final authStateProvider = StreamProvider<User>((ref) {
  return ref.watch(authServiceProvider).authState;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return ref.watch(authStateProvider).map(
        data: (AsyncData<User> user) {
          return UserRepository(user.value.uid);
        },
        loading: (AsyncLoading<User> value) => UserRepository(null),
        error: (AsyncError<User> value)=> UserRepository(null),
      );
});

final loggerProvider = Provider<Logger>((ref) => Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        printEmojis: false,
      ),
    ));
