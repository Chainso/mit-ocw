import 'dart:math';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedResults<CURSOR, ITEM> {
  final List<PagedItem<CURSOR, ITEM>> items;
  final bool hasPrevious;
  final bool hasNext;

  PaginatedResults({
    required this.items,
    required this.hasPrevious,
    required this.hasNext,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  CURSOR? get startCursor => isNotEmpty ? items.first.cursor : null;
  CURSOR? get endCursor => isNotEmpty ? items.last.cursor : null;
}

class PagedItem<CURSOR, ITEM> {
  final CURSOR cursor;
  final ITEM item;

  PagedItem({required this.cursor, required this.item});

  PagedItem<CURSOR, NEW_ITEM> map<NEW_ITEM>(NEW_ITEM Function(ITEM) mapper) {
    return PagedItem(cursor: cursor, item: mapper(item));
  }
}

class PaginatedQuery<CURSOR, ITEM> {
  final Future<PaginatedResults<CURSOR, ITEM>> Function(CURSOR?, int?) fetchPage;
  List<CURSOR> cursors = [];

  PaginatedQuery({required this.fetchPage});

  Future<PaginatedResults<CURSOR, ITEM>> fetchFirstPage(int? size) async {
    final results = await fetchPage(null, size);

    if (results.endCursor != null) {
      cursors.clear();
      cursors.add(results.endCursor!);
    }

    return results;
  }

  Future<PaginatedResults<CURSOR, ITEM>> fetchNextPage(int? size) async {
    final results = await fetchPage(cursors.lastOrNull, size);

    if (results.endCursor != null) {
      cursors.add(results.endCursor!);
    }

    return results;
  }

  void addListenerToPagingController(PagingController<CURSOR, ITEM> pagingController, int? size) {
    pagingController.addPageRequestListener((key) {
      fetchPage(key, size)
        .then((results) {
          final pageItems = results.items.map((item) => item.item).toList();

          if (results.hasNext) {
            pagingController.appendPage(pageItems, results.endCursor);
          } else {
            pagingController.appendLastPage(pageItems);
          }
        })
        .catchError((error) {
          pagingController.error = error;
        });
    });
  }
}

class StaticListPaginatedQuery<ITEM> extends PaginatedQuery<int, ITEM> {
  final List<ITEM> items;

  StaticListPaginatedQuery({required this.items})
      : super(fetchPage: (cursor, pageSize) => StaticListPaginatedQuery._fetchPageAsync<ITEM>(items, cursor, pageSize));

  static Future<PaginatedResults<int, ITEM>> _fetchPageAsync<ITEM>(List<ITEM> items, int? cursor, int? pageSize) async {
    return Future.value(StaticListPaginatedQuery._fetchPageSync<ITEM>(items, cursor, pageSize));
  }

  static PaginatedResults<int, ITEM> _fetchPageSync<ITEM>(List<ITEM> items, int? cursor, int? pageSize) {
    final startIndex = cursor ?? 0;
    final endIndex = pageSize != null ? min(startIndex + pageSize, items.length) : items.length;

    final pageResults = items.sublist(startIndex, endIndex);
    final pageItems = List.generate(pageResults.length, (index) => PagedItem(cursor: startIndex + index + 1, item: pageResults[index]));

    return PaginatedResults(
      items: pageItems,
      hasPrevious: startIndex > 0,
      hasNext: endIndex < items.length,
    );
  }
}
