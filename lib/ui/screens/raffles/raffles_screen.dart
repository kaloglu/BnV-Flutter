import 'package:BedavaNeVar/app/top_level_providers.dart';
import 'package:BedavaNeVar/constants/constants.dart';
import 'package:BedavaNeVar/models/models.dart';
import 'package:BedavaNeVar/ui/screens/raffles/list_items_builder.dart';
import 'package:BedavaNeVar/ui/widgets/common/show_alert_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/common/show_exception_alert_dialog.dart';
import 'package:BedavaNeVar/ui/widgets/raffle/raffle_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';

final raffleStreamProvider = StreamProvider.autoDispose<List<Raffle>>((ref) {
  final database = ref.watch(databaseProvider);
  return database?.rafflesStream() ?? const Stream.empty();
});

// watch database
class RafflesScreen extends HookWidget {
  Future<void> _delete(BuildContext context, Raffle raffle) async {
    try {
      final database = useProvider(databaseProvider);
      await database.deleteRaffle(raffle);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.raffles),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => {}, //EditRafflePage.show(context),
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final rafflesStream = useProvider(raffleStreamProvider);

    return ListItemsBuilder<Raffle>(
      data: rafflesStream,
      itemBuilder: (context, raffle) => Dismissible(
        key: Key('raffle-${raffle.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _delete(context, raffle),
        child: RaffleListItem(
          item: raffle,
          onTap: (raffle) => {
            showAlertDialog(
              context: context,
              title: raffle.title,
              content: raffle.description,
              defaultActionText: "Tamam",
            )
          }, //RaffleEntriesPage.show(context, raffle),
        ),
      ),
    );
  }
}
