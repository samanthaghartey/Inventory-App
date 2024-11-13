import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part "item_model.g.dart";

@HiveType(typeId: 1)
class Item_Model extends ChangeNotifier {
  static int itemCount = 0;
  static List<Item_Model> _items = [];

  @HiveField(0)
  String name;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  int quantitytoBuy = 0;
  @HiveField(3)
  double price;
  @HiveField(4)
  String location;
  @HiveField(5)
  String priority;
  @HiveField(6)
  String type;

  Item_Model({
    required this.name,
    required this.quantity,
    required this.price,
    required this.location,
    required this.priority,
    this.type = "",
  }) {
    _items.add(this);
    itemCount++;
  }

  double get priceToBuy => quantitytoBuy * price;

  static List<Item_Model> get items => _items;
}
