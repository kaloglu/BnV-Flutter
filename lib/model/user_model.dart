import 'package:bnv/model/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


@immutable
class User extends BaseModel {
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

  const User({
    Key key,
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
  }) : super(key: key);

  @override
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'fullname': fullname,
        'gender': gender,
        'gsm': gsm,
        'profilePicUrl': profilePicUrl,
        'username': username,
        'age': age,
        'country': country,
        'city': city,
        'address': address,
        'deviceToken': deviceToken,
      };

  static User fromFirestore(DocumentSnapshot doc) => fromMap(doc.data, doc.documentID);

  static List<User> listFromFirestore<T>(QuerySnapshot query) => query.documents.map(fromFirestore).toList();

  static User fromMap(Map data, [String documentId]) => User(
        uid: documentId,
        email: data['email'] ?? '',
        fullname: data['fullname'] ?? '',
        profilePicUrl: data['profilePicUrl'] ?? '',
        gender: data['gender'],
        gsm: data['gsm'],
        username: data['username'],
        age: data['age'],
        country: data['country'],
        city: data['city'],
        address: data['address'],
        deviceToken: data['deviceToken'],
      );

  static User userFromFirebaseAuth(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;

    return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        fullname: firebaseUser.displayName,
        profilePicUrl: firebaseUser.photoUrl
    );
  }
}
