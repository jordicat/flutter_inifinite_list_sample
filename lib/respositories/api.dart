import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../models/item.dart';

const int itemsPerPage = 20;

Future<ItemPage> fetchPage(int startingIndex) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return ItemPage(
    items: List.generate(
      itemsPerPage,
      (index) => Item(
        color: Colors.primaries[index % Colors.primaries.length],
        name: "Color #${startingIndex + index}",
        price: 50 + (index * 42) % 200,
      ),
    ),
    startingIndex: startingIndex,
    hasNext: true,
  );
}

class ItemPage {
  final List<Item> items;
  final int startingIndex;
  final bool hasNext;

  ItemPage({
    @required this.items,
    @required this.startingIndex,
    @required this.hasNext,
  });
}
