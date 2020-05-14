import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'src/api/item.dart';
import 'src/api/page.dart';

class Catalog extends ChangeNotifier {
  final Map<int, ItemPage> _pages = {};

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
    _pages[startingIndex] = await fetchPage(startingIndex);
    print('current pages: ${_pages.keys}');
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
