import 'package:BedavaNeVar/ui/widgets/common/EmptyContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends HookWidget {
  const ListItemsBuilder({
    Key key,
    @required this.data,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) => _buildList(items),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (object, stacktrace) => Center(
        child: EmptyContent(
          title: 'Kampanya listesi alınırken bir hata oluştu 😲',
          message: object.toString(),
        ),
      ),
    );
  }

  Widget _buildList(List<T> items) {
    if (items.isEmpty)
      return EmptyContent(
        title: "Bulamadık! 😥",
        message: "Şu an yayınlanmış bir kampanya bulunmuyor...",
      );
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
