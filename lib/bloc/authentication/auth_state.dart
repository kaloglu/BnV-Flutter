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

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => "Unauthenticated";
}
