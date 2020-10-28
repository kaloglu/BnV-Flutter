import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/repositories/interfaces/repository.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/utils/firebase/Collection.dart';

class RaffleRepository implements Repository {
  RaffleRepository();

  Stream<List<Raffle>> getRaffles() {
    return Collection<Raffle>(path: Constants.RAFFLES).streamData();
  }
}
