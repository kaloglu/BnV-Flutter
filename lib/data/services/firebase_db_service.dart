import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/utils/firebase/firebase_helper.dart';

export 'package:cloud_firestore/cloud_firestore.dart';

mixin DBService {
  Stream<List<Raffle>> getRaffles() {
    return RaffleCollection().streamData();
  }
}
