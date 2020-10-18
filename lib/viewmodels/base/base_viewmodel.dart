import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/repositories/interfaces/repository.dart';

mixin busyable {
  bool busy = false;
}

abstract class BaseViewModel<R extends Repository> extends ChangeNotifier with busyable {
  R repository;

  BaseViewModel(this.repository);

  @override
  set busy(value) {
    super.busy = value;
    notifyListeners();
  }
}

abstract class BaseViewModel2<R extends Repository, R2 extends Repository> extends BaseViewModel<R> {
  R2 repository2;

  BaseViewModel2(
    R repository,
    this.repository2,
  ) : super(repository);
}

abstract class BaseViewModel3<R extends Repository, R2 extends Repository, R3 extends Repository>
    extends BaseViewModel2<R, R2> {
  R3 repository3;

  BaseViewModel3(
    R repository,
    R2 repository2,
    this.repository3,
  ) : super(repository, repository2);
}

abstract class BaseViewModel4<R extends Repository, R2 extends Repository, R3 extends Repository, R4 extends Repository>
    extends BaseViewModel3<R, R2, R3> {
  R4 repository4;

  BaseViewModel4(
    R repository,
    R2 repository2,
    R3 repository3,
    this.repository4,
  ) : super(repository, repository2, repository3);
}
