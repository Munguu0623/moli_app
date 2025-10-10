// lib/ui/molecules/paged_list.dart
import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext, int);

class PagedList extends StatelessWidget {
  final int itemCount;
  final ItemBuilder itemBuilder;
  final bool loadingMore;
  final Future<void> Function() onLoadMore;
  final Future<void> Function()? onRefresh;
  const PagedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.loadingMore,
    required this.onLoadMore,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext c) => NotificationListener<ScrollNotification>(
    onNotification: (n) {
      if (n.metrics.pixels >= n.metrics.maxScrollExtent - 320 && !loadingMore) {
        onLoadMore();
      }
      return false;
    },
    child: RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: itemCount + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (ctx, i) {
          KeyedSubtree keyedSubtree = KeyedSubtree(
            key: ValueKey(i),
            child: itemBuilder(ctx, i),
          );
          if (i == itemCount) {
            return loadingMore
                ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
                : const SizedBox.shrink();
          }
          return keyedSubtree;
        },
      ),
    ),
  );
}
