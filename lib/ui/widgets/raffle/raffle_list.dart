import 'package:BedavaNeVar/constants/constants.dart';

class RaffleList extends StatefulWidget {
  const RaffleList({Key key}) : super(key: key);

  @override
  _RaffleListState createState() => _RaffleListState();
}

class _RaffleListState extends State<RaffleList> {
  @override
  Widget build(BuildContext context) {
    return EmptyRaffleList();
  }
}

class EmptyRaffleList extends StatelessWidget {
  const EmptyRaffleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Kampanya bulunamadı"));
  }
}
