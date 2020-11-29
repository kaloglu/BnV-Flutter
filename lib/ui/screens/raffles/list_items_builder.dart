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
      data: (items) {
        return items.isNotEmpty ? _buildList(items) : const EmptyContent();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (object, stacktrace) {
        print(object);
        return Center(
          child: EmptyContent(
            title: 'Kampanya listesi alınırken bir hata oluştu 😲',
            message: object.toString(),
          ),
        );
      },
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => const Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container(); // zero height: not visible
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
