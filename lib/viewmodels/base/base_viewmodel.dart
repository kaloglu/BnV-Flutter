import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/repositories/interfaces/repository.dart';

abstract class BaseViewModel<R extends Repository> extends ChangeNotifier {
  R _repository;
  bool _busy = false;

  bool get busy => _busy;

  set busy(value) {
    _busy = value;
    notifyListeners();
  }

  R get repository => _repository;

  set repository(value) => _repository = value;
}
