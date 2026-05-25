
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/data/repositories/raffle_repository.dart';
import 'package:BedavaNeVar/models/raffle_model.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffle_list_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../raffle/detail/raffle_detail_screen.dart';
import 'list_items_builder.dart';

final rafflesStreamProvider = StreamProvider.autoDispose<List<Raffle>>(
  (_) => RaffleRepository.rafflesStream() ?? const Stream.empty(),
);

// watch database
class RafflesScreen extends HookWidget {
  // Future<void> _delete(BuildContext context, Raffle raffle) async {
  //   try {
  //     final database = useProvider(databaseProvider);
  //     await database.deleteRaffle(raffle);
  //   } catch (e) {
  //     unawaited(showExceptionAlertDialog(
  //       context: context,
  //       title: 'Operation failed',
  //       exception: e,
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.raffles),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final rafflesStream = useProvider(rafflesStreamProvider);
    return ListItemsBuilder<Raffle>(
      data: rafflesStream,
      itemBuilder: (context, raffle) => Dismissible(
        key: Key('raffle-${raffle.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        // onDismissed: (direction) => _delete(context, raffle),
        child: RaffleListItem(
          item: raffle,
          onTap: (raffle) => RaffleDetailScreen.show(context, raffle.id),
        ),
      ),
    );
  }
}
