import 'package:BedavaNeVar/model/base/base_model.dart';
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
  Map<String, dynamic> toJson() => {
        'maxAttendee': maxAttendee,
        'maxAttendByUser': maxAttendByUser,
      };

  static RaffleRules fromMap(Map data) => RaffleRules(
        maxAttendee: data['maxAttendee'] ?? 0,
        maxAttendByUser: data['maxAttendByUser'] ?? 0,
      );
}
