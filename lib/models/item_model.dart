import 'package:hive_flutter/adapters.dart';

part "item_model.g.dart";

@HiveType(typeId: 1)
class Item_Model {
  static int itemCount = 0;
  static final List<Item_Model> _items = [];

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
  @HiveField(7)
  int id;
  @HiveField(8)
  double get priceToBuy => quantitytoBuy * price;
  @HiveField(9)
  bool isInShoppingCart = true;

  Item_Model(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.location,
      required this.priority,
      this.type = "",
      required this.id,
      this.isInShoppingCart = true,
      this.quantitytoBuy = 0}) {
    _items.add(this);
    itemCount++;
  }

  // CopyWith method
  Item_Model copyWith({
    String? name,
    int? quantity,
    double? price,
    String? location,
    String? priority,
    String? type,
    int? id,
    bool? isInShoppingCart,
    int? quantitytoBuy,
  }) {
    return Item_Model(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      location: location ?? this.location,
      priority: priority ?? this.priority,
      type: type ?? this.type,
      id: id ?? this.id,
      isInShoppingCart: isInShoppingCart ?? this.isInShoppingCart,
      quantitytoBuy: quantitytoBuy ?? this.quantitytoBuy,
    );
  }

  static List<Item_Model> get items => _items;
}
