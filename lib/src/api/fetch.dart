import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/page.dart';

const int itemsPerPage = 20;
const catalogLength = 200;

Future<ItemPage> fetchPage(int startingIndex) async {
  await Future.delayed(const Duration(milliseconds: 500));

  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

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
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}
