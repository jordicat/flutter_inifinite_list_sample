import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'src/api/fetch.dart';
import 'src/models/item.dart';
import 'src/models/page.dart';

class Catalog extends ChangeNotifier {
  final Map<int, ItemPage> _pages = {};
  final Set<int> _pagesBeingFetched = {};

  int itemCount;

  Item getByIndex(int index) {
    var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;

    if (_pages.containsKey(startingIndex)) {
      var item = _pages[startingIndex].items[index - startingIndex];
      return item;
    }
    _fetchPage(startingIndex);
    return Item.loading();
  }

  static const maxCacheDistance = 100;

  void _fetchPage(int startingIndex) async {
    if (_pagesBeingFetched.contains(startingIndex)) {
      return;
    }

    _pagesBeingFetched.add(startingIndex);
    final page = await fetchPage(startingIndex);
    _pagesBeingFetched.remove(startingIndex);

    if (!page.hasNext) {
      itemCount = startingIndex + page.items.length;
    }
    _pages[startingIndex] = page;
    _pruneCache(startingIndex);
    notifyListeners();
  }

  void _pruneCache(int currentStartingIndex) {
    final keysToRemove = <int>{};
    for (final key in _pages.keys) {
      if ((key - currentStartingIndex).abs() > maxCacheDistance) {
        keysToRemove.add(key);
      }
    }
    for (final key in keysToRemove) {
      _pages.remove(key);
    }
  }
}
