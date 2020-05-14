import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Item {
  final Color color;
  final int price;
  final String name;

  Item({
    @required this.color,
    @required this.price,
    @required this.name,
  });

  Item.loading() : this(color: Colors.grey, name: '...', price: 0);

  get isLoading => name == 'loading';
}
