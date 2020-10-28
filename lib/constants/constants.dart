import 'package:BedavaNeVar/models/models.dart';

export 'package:BedavaNeVar/constants/colors.dart';
export 'package:BedavaNeVar/constants/enums.dart';
export 'package:BedavaNeVar/constants/strings.dart';
export 'package:BedavaNeVar/constants/style.dart';
export 'package:flutter/material.dart';

class Constants {
  static const String USERS = "users";
  static const String RAFFLES = "raffles";
  static const String DEVICE_TOKENS = "deviceTokens";

  static const String ATTENDEES = "attendees";
  static const String TICKETS = "tickets";
  static const String ENROLLS = "enrolls";

// Data Models
  static final Map models = {
    Raffle: (data) => Raffle.fromMap(data),
    ProductInfo: (data) => ProductInfo.fromMap(data),
    RaffleRules: (data) => RaffleRules.fromMap(data),
  };
}
