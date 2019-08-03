import 'package:bnv/model/raffle_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RaffleListEvent extends Equatable {
  RaffleListEvent([List props = const []]) : super(props);
}

class LoadList extends RaffleListEvent {
  @override
  String toString() => "LoadList";
}

class LoadedList extends RaffleListEvent {
  final List<Raffle> raffleList;

  LoadedList([this.raffleList = const []]) : super([raffleList]);

  @override
  String toString() => "LoadedList";
}

class GetDetail extends RaffleListEvent {
  final Raffle raffle;

  GetDetail(this.raffle) : super([raffle]);

  @override
  String toString() => "GetDetail";
}


