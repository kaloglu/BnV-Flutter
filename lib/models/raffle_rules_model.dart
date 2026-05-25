import 'package:BedavaNeVar/models/base/base_model.dart';
import 'package:flutter/material.dart';

@immutable
class RaffleRules extends BaseModel {
  final int maxAttendee;
  final int maxAttendByUser;

  const RaffleRules({
    super.key,
    this.maxAttendee = 0,
    this.maxAttendByUser = 0,
  });

  @override
  List<Object> get props => [
        maxAttendee,
        maxAttendByUser,
      ];

  factory RaffleRules.fromMap(Map<String, dynamic>? data) => RaffleRules(
        maxAttendee: (data?['maxAttendee'] as int?) ?? 0,
        maxAttendByUser: (data?['maxAttendByUser'] as int?) ?? 0,
      );

  @override
  Map<String, dynamic> toMap() => {
        'maxAttendee': maxAttendee,
        'maxAttendByUser': maxAttendByUser,
      };
}
