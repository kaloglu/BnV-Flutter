// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    uid: json['uid'] as String,
    email: json['email'] as String,
    fullname: json['fullname'] as String,
    gender: json['gender'] as String,
    gsm: json['gsm'] as String,
    profilePicUrl: json['profilePicUrl'] as String,
    username: json['username'] as String,
    age: json['age'] as int,
    country: json['country'] as String,
    city: json['city'] as String,
    address: json['address'] as String,
    deviceToken: json['deviceToken'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'fullname': instance.fullname,
      'gender': instance.gender,
      'gsm': instance.gsm,
      'profilePicUrl': instance.profilePicUrl,
      'username': instance.username,
      'age': instance.age,
      'country': instance.country,
      'city': instance.city,
      'address': instance.address,
      'deviceToken': instance.deviceToken,
    };
