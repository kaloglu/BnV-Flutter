import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bnv/bloc/raffle_list/bloc.dart';
import 'package:bnv/data/repository/raffle_repository.dart';

class RaffleListBloc extends Bloc<RaffleListEvent, RaffleListState> {
  final RaffleRepository _repository = RaffleRepository();
  StreamSubscription _raffleListSubscription;

  @override
  RaffleListState get initialState => Loading();

  @override
  Stream<RaffleListState> mapEventToState(RaffleListEvent event) async* {
    if (event is LoadList) {
      yield Loading();
      yield* _mapLoadRaffleListToState();
    } else if (event is LoadedList) {
      yield* _mapLoadedRaffleListToState(event);
    }
  }

  Stream<RaffleListState> _mapLoadRaffleListToState() async* {
    _raffleListSubscription?.cancel();
    _raffleListSubscription = _repository.getRaffles().listen((raffleList) {
      dispatch(
        LoadedList(raffleList),
      );
    });
  }

  Stream<RaffleListState> _mapLoadedRaffleListToState(LoadedList event) async* {
    if (event.raffleList.length <= 0)
      yield Empty();
    else
      yield Content(event.raffleList);
  }

  @override
  void dispose() {
    _raffleListSubscription?.cancel();
    super.dispose();
  }
}
