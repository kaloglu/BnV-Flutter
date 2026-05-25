import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User extends BaseModel implements _$User {
  const User._();

  const factory User({
    String uid,
    String email,
    String fullname,
    String gender,
    String gsm,
    String profilePicUrl,
    String username,
    int age,
    String country,
    String city,
    String address,
    String deviceToken,
  }) = _User;

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null || doc.data() == null) return null;
    return User.fromJson(doc.data()).copyWith(uid: doc.id);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.userFromSocialAuth(Firebase.User firebaseUser) => User(
        uid: firebaseUser?.uid,
        email: firebaseUser?.email,
        fullname: firebaseUser?.displayName,
        profilePicUrl: firebaseUser?.photoURL,
      );
}
