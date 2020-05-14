import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'item.dart';

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
