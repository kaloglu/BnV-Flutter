import 'package:bnv/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class AuthInit extends AuthenticationState {
  @override
  String toString() => "AuthInit";
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => "Authenticated => ${user.fullname}";
}
class HomeScreen extends AuthenticationState {
  final User user;

  HomeScreen(this.user) : super([user]);

  @override
  String toString() => "HomeScreen => ${user.fullname}";
}
class LoginScreen extends AuthenticationState {

  @override
  String toString() => "LoginScreen";
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => "Unauthenticated";
}
