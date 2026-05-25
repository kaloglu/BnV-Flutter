import 'package:BedavaNeVar/models/models.dart';
import 'package:intl/intl.dart';

import '../BnvApp.dart';

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

  static const String LONG_DATE_TIME_FORMAT = "dd MMMM yyyy HH:mm";
  static const String SHORT_DATE_TIME_FORMAT = "dd MM YYYY HH:mm";

// Data Models
  static final Map models = {
    Raffle: (data) => Raffle.fromMap(data, data.id),
    ProductInfo: (data) => ProductInfo.fromMap(data),
    RaffleRules: (data) => RaffleRules.fromMap(data),
    User: (data) => User.fromJson(data),
  };

  static readableDate({DateFormatType type, DateTime date}) {
    var dateFormat;

    switch (type) {
      case DateFormatType.LONG:
        dateFormat = DateFormat.yMMMMEEEEd('tr_TR');
        break;
      default:
        dateFormat = DateFormat.yMMMd('tr_TR');
        break;
    }
    return dateFormat.format(date);
  }
}
