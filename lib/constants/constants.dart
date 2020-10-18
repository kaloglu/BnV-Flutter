import 'package:BedavaNeVar/models/models.dart';

export 'package:BedavaNeVar/constants/colors.dart';
export 'package:BedavaNeVar/constants/enums.dart';
export 'package:BedavaNeVar/constants/strings.dart';
export 'package:BedavaNeVar/constants/style.dart';
export 'package:flutter/material.dart';

class Global {
// Data Models
  static final Map models = {
    Raffle: (data) => Raffle.fromDocumentSnapshot(data),
    ProductInfo: (data) => ProductInfo.fromMap(data),
    RaffleRules: (data) => RaffleRules.fromMap(data),
  };
}
