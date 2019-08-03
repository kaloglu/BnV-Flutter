import 'package:bnv/model/raffle_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RaffleListState extends Equatable {
  RaffleListState([List props = const []]) : super(props);
}

class Loading extends RaffleListState {
  @override
  String toString() => "Loading";
}

class Content extends RaffleListState {
  final List<Raffle> data;

  Content(this.data) : super([data]);

  @override
  String toString() => "Content => ${data.length}";
}

class Detail extends RaffleListState {
  final Raffle raffle;

  Detail(this.raffle) : super([raffle]);

  @override
  String toString() => "Detail => ${raffle.title}";
}

class Empty extends RaffleListState {
  @override
  String toString() => "Empty";
}

class Error extends RaffleListState {
  @override
  String toString() => "Error";
}
