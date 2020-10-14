import 'package:BedavaNeVar/data/repositories/login_repository.dart';
import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/data/services/auth/firebase_auth_service.dart';
import 'package:BedavaNeVar/data/services/db/firestore_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/raffle_list_viewmodel.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:provider/provider.dart';

List<SingleChildWidget> dependent2Services = [
  ProxyProvider4<FirebaseAuth, GoogleSignIn, FacebookAuth, FirestoreDBService, FirebaseAuthService>(
    update: (context, firebaseAuth, googleSignIn, facebookAuth, firestoreDbService, firebaseAuthService) =>
        FirebaseAuthService(
            firebaseAuth: firebaseAuth,
            googleSignIn: googleSignIn,
            facebookAuth: facebookAuth,
            firestoreDB: firestoreDbService),
  ),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<FirebaseFirestore, FirestoreDBService>(
    update: (context, firestore, firestoreDbService) => FirestoreDBService(firestore: firestore),
  ),
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Firebase.app()),
  Provider.value(value: FirebaseAuth.instance),
  Provider.value(value: FirebaseFirestore.instance),
  Provider.value(value: GoogleSignIn()),
  Provider.value(value: FacebookAuth.instance),
];

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...dependent2Services,
  ...repositories,
  ...uiConsumableProviders
];

List<SingleChildWidget> repositories = [
  ProxyProvider<FirebaseAuthService, LoginRepository>(
    update: (context, firebaseAuth, loginRepository) => LoginRepository(auth: firebaseAuth),
  ),
  ProxyProvider<FirestoreDBService, RaffleRepository>(
    update: (context, firestoreDbService, loginRepository) => RaffleRepository(db: firestoreDbService),
  ),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProxyProvider<LoginRepository, AuthViewModel>(
    update: (context, loginRepository, authViewModel) => authViewModel..repository = loginRepository,
    create: (context) => AuthViewModel(),
  ),
  ListenableProxyProvider<RaffleRepository, RaffleListViewModel>(
    update: (context, raffleRepository, raffleListViewModel) => raffleListViewModel..repository = raffleRepository,
    create: (context) => RaffleListViewModel(),
  ),
  StreamProvider<User>(
    create: (context) => Provider.of<AuthViewModel>(context, listen: false).stateChanges,
  )
];
