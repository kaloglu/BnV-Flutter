import 'dart:async';

import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    @required this.email,
    @required this.fullname,
    @required this.profilePicUrl,
    this.deviceToken,
    this.gender,
    this.gsm,
    this.username,
    this.age,
    this.country,
    this.city,
    this.address,
  });

  final String uid;
  final String email;
  final String fullname;
  final String gender;
  final String gsm;
  final String profilePicUrl;
  final String username;
  final String age;
  final String country;
  final String city;
  final String address;
  final String deviceToken;
}

abstract class AuthService {
  Future<User> currentUser();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> signOut();

  Stream<User> get onAuthStateChanged;

  void dispose();
}
