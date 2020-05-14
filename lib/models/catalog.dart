import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_infinite_list_sample/respositories/api.dart';

import 'item.dart';

class Catalog extends ChangeNotifier {
  final Map<int, ItemPage> _pages = {};

  Item getByIndex(int index) {
    var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;

    if (_pages.containsKey(startingIndex)) {
      var item = _pages[startingIndex].items[index - startingIndex];
      print(item.name);
      return item;
    }

    _fetchPage(startingIndex);
    return Item.loading();
  }

  void _fetchPage(int startingIndex) async {
    print(startingIndex);
    _pages[startingIndex] = await fetchPage(startingIndex);
    // TODO: clean pages not needed anymore
    notifyListeners();
  }
}
