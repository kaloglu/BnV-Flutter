import 'package:bnv/data/repository/login_repository.dart';
import 'package:bnv/data/repository/raffle_repository.dart';
import 'package:bnv/data/services/auth/firebase_auth_service.dart';
import 'package:bnv/data/services/db/firestore_db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'model/user_model.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/raffle_list_viewmodel.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...dependent2Services,
  ...repositories,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: FirebaseAuth.instance),
  Provider.value(value: Firestore.instance),
  Provider.value(value: GoogleSignIn()),
  Provider.value(value: FacebookLogin()),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Firestore, FirestoreDBService>(
    builder: (context, firestore, firestoreDbService) => FirestoreDBService(firestore: firestore),
  ),
];

List<SingleChildCloneableWidget> dependent2Services = [
  ProxyProvider4<FirebaseAuth, GoogleSignIn, FacebookLogin, FirestoreDBService, FirebaseAuthService>(
    builder: (context, firebaseAuth, googleSignIn, facebookLogin, firestoreDbService, firebaseAuthService) =>
        FirebaseAuthService(
            firebaseAuth: firebaseAuth,
            googleSignIn: googleSignIn,
            facebookLogin: facebookLogin,
            firestoreDB: firestoreDbService),
  ),
];

List<SingleChildCloneableWidget> repositories = [
  ProxyProvider<FirebaseAuthService, LoginRepository>(
    builder: (context, firebaseAuth, loginRepository) => LoginRepository(auth: firebaseAuth),
  ),
  ProxyProvider<FirestoreDBService, RaffleRepository>(
    builder: (context, firestoreDbService, loginRepository) => RaffleRepository(db: firestoreDbService),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  ChangeNotifierProxyProvider<LoginRepository, AuthViewModel>(
    builder: (context, loginRepository, authViewModel) => authViewModel..repository = loginRepository,
    initialBuilder: (context) => AuthViewModel(),
  ),
  ListenableProxyProvider<RaffleRepository, RaffleListViewModel>(
    builder: (context, raffleRepository, raffleListViewModel) => raffleListViewModel..repository = raffleRepository,
    initialBuilder: (context) => RaffleListViewModel(),
  ),
  StreamProvider<User>(
    builder: (context) =>
    Provider
        .of<AuthViewModel>(context, listen: false)
        .onAuthStateChanged,
  )
];
