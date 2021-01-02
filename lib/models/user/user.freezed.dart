// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

// ignore: unused_element
  _User call(
      {String uid,
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
      String deviceToken}) {
    return _User(
      uid: uid,
      email: email,
      fullname: fullname,
      gender: gender,
      gsm: gsm,
      profilePicUrl: profilePicUrl,
      username: username,
      age: age,
      country: country,
      city: city,
      address: address,
      deviceToken: deviceToken,
    );
  }

// ignore: unused_element
  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get uid;
  String get email;
  String get fullname;
  String get gender;
  String get gsm;
  String get profilePicUrl;
  String get username;
  int get age;
  String get country;
  String get city;
  String get address;
  String get deviceToken;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
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
      String deviceToken});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object fullname = freezed,
    Object gender = freezed,
    Object gsm = freezed,
    Object profilePicUrl = freezed,
    Object username = freezed,
    Object age = freezed,
    Object country = freezed,
    Object city = freezed,
    Object address = freezed,
    Object deviceToken = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      fullname: fullname == freezed ? _value.fullname : fullname as String,
      gender: gender == freezed ? _value.gender : gender as String,
      gsm: gsm == freezed ? _value.gsm : gsm as String,
      profilePicUrl: profilePicUrl == freezed
          ? _value.profilePicUrl
          : profilePicUrl as String,
      username: username == freezed ? _value.username : username as String,
      age: age == freezed ? _value.age : age as int,
      country: country == freezed ? _value.country : country as String,
      city: city == freezed ? _value.city : city as String,
      address: address == freezed ? _value.address : address as String,
      deviceToken:
          deviceToken == freezed ? _value.deviceToken : deviceToken as String,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
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
      String deviceToken});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object fullname = freezed,
    Object gender = freezed,
    Object gsm = freezed,
    Object profilePicUrl = freezed,
    Object username = freezed,
    Object age = freezed,
    Object country = freezed,
    Object city = freezed,
    Object address = freezed,
    Object deviceToken = freezed,
  }) {
    return _then(_User(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      fullname: fullname == freezed ? _value.fullname : fullname as String,
      gender: gender == freezed ? _value.gender : gender as String,
      gsm: gsm == freezed ? _value.gsm : gsm as String,
      profilePicUrl: profilePicUrl == freezed
          ? _value.profilePicUrl
          : profilePicUrl as String,
      username: username == freezed ? _value.username : username as String,
      age: age == freezed ? _value.age : age as int,
      country: country == freezed ? _value.country : country as String,
      city: city == freezed ? _value.city : city as String,
      address: address == freezed ? _value.address : address as String,
      deviceToken:
          deviceToken == freezed ? _value.deviceToken : deviceToken as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_User extends _User {
  const _$_User(
      {this.uid,
      this.email,
      this.fullname,
      this.gender,
      this.gsm,
      this.profilePicUrl,
      this.username,
      this.age,
      this.country,
      this.city,
      this.address,
      this.deviceToken})
      : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String fullname;
  @override
  final String gender;
  @override
  final String gsm;
  @override
  final String profilePicUrl;
  @override
  final String username;
  @override
  final int age;
  @override
  final String country;
  @override
  final String city;
  @override
  final String address;
  @override
  final String deviceToken;

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, fullname: $fullname, gender: $gender, gsm: $gsm, profilePicUrl: $profilePicUrl, username: $username, age: $age, country: $country, city: $city, address: $address, deviceToken: $deviceToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.fullname, fullname) ||
                const DeepCollectionEquality()
                    .equals(other.fullname, fullname)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.gsm, gsm) ||
                const DeepCollectionEquality().equals(other.gsm, gsm)) &&
            (identical(other.profilePicUrl, profilePicUrl) ||
                const DeepCollectionEquality()
                    .equals(other.profilePicUrl, profilePicUrl)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.city, city) ||
                const DeepCollectionEquality().equals(other.city, city)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.deviceToken, deviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.deviceToken, deviceToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(fullname) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(gsm) ^
      const DeepCollectionEquality().hash(profilePicUrl) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(age) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(deviceToken);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User extends User {
  const _User._() : super._();
  const factory _User(
      {String uid,
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
      String deviceToken}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String get fullname;
  @override
  String get gender;
  @override
  String get gsm;
  @override
  String get profilePicUrl;
  @override
  String get username;
  @override
  int get age;
  @override
  String get country;
  @override
  String get city;
  @override
  String get address;
  @override
  String get deviceToken;
  @override
  _$UserCopyWith<_User> get copyWith;
}
