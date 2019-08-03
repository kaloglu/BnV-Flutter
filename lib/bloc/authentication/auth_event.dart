import 'package:bnv/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => "AppStarted";
}

class LoggedIn extends AuthenticationEvent {
  final User user;

  LoggedIn(this.user) :super([user]);

  @override
  String toString() => "GoHomeScreen";
}
class GoHomeScreen extends AuthenticationEvent {
  final User user;

  GoHomeScreen(this.user) :super([user]);

  @override
  String toString() => "GoHomeScreen";
}

class GoLoginScreen extends AuthenticationEvent {
  @override
  String toString() => "GoLoginScreen";
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => "LoggedOut";
}
