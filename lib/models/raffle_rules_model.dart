import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:flutter/material.dart';

@immutable
class RaffleRules extends BaseModel {
  final int maxAttendee;
  final int maxAttendByUser;

  const RaffleRules({
    Key key,
    this.maxAttendee,
    this.maxAttendByUser,
  }) : super(key: key);

  @override
  List<Object> get props => [
        maxAttendee,
        maxAttendByUser,
      ];

  factory RaffleRules.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return RaffleRules(
      maxAttendee: data['maxAttendee'] ?? 0,
      maxAttendByUser: data['maxAttendByUser'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'maxAttendee': maxAttendee,
        'maxAttendByUser': maxAttendByUser,
      };
}
