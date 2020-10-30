import 'package:BedavaNeVar/data/repositories/login_repository.dart';
import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/models/user_model.dart';
import 'package:BedavaNeVar/viewmodels/auth_viewmodel.dart';
import 'package:BedavaNeVar/viewmodels/raffles.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:provider/provider.dart';

List<SingleChildWidget> providers = [...repositories, ...uiConsumableProviders];

List<SingleChildWidget> repositories = [
  ProxyProvider0<LoginRepository>(update: (context, loginRepository) => LoginRepository()),
  ProxyProvider0<RaffleRepository>(update: (context, raffleRepository) => RaffleRepository()),
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProxyProvider<LoginRepository, AuthViewModel>(
    lazy: true,
    update: (context, loginRepository, viewModel) => viewModel..repository = loginRepository,
    create: (context) => AuthViewModel(),
  ),
  ListenableProxyProvider<RaffleRepository, RaffleListViewModel>(
    lazy: true,
    update: (context, raffleRepository, raffleListViewModel) => raffleListViewModel..repository = raffleRepository,
    create: (context) => RaffleListViewModel(),
  ),
  StreamProvider<bool>(create: (context) => Provider.of<AuthViewModel>(context).isLoggedIn$),
  FutureProvider<User>(create: (context) => Provider.of<AuthViewModel>(context).getUser()),
];
