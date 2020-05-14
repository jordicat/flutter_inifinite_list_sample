import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';

class Catalog extends ChangeNotifier {
  Item getByIndex(int index) {
    return Item(
      color: Colors.primaries[index % Colors.primaries.length],
      name: "Color #$index",
      price: 50 + (index * 42) % 200,
    );
  }
}
