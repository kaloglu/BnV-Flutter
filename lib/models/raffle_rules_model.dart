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

  factory RaffleRules.fromMap(Map<String, dynamic> data) => RaffleRules(
        maxAttendee: data['maxAttendee'] ?? 0,
        maxAttendByUser: data['maxAttendByUser'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        'maxAttendee': maxAttendee,
        'maxAttendByUser': maxAttendByUser,
      };
}
