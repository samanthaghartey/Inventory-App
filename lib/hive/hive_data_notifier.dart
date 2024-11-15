import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/item_static_properties.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataNotifier extends ChangeNotifier {
  final Box _box;
  final Box _boxLists;

  HiveDataNotifier(this._box, this._boxLists) {
    _box.listenable().addListener(_onBoxUpdated);
  }

  Item_Model getData(String key) => _box.get(key);

//Getters
  Box get getBox => _box;

  List<String> get locations =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!.locations;
  List<String> get userLocations =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!.userLocations;
  Item_list get itemList =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!;

  // GETTER FOR TOTAL PRICE
  double totalCost() {
    List costList = _box.values.isEmpty
        ? [0.0]
        : _box.values.map((item) => item.quantitytoBuy * item.price).toList();
    return costList.reduce((a, b) => a + b);
  }

  List<Item_Model> filteredItems = [];
  List<String> get priorities => itemList.priorities;

//ADD LOCATION
  void addLocation(String location) {
    itemList.addUserLocation(location);
    _boxLists.put('itemListKey', itemList);
    notifyListeners();
  }

//APP PRIORITY
  void addPriority(String priority) {
    itemList.addUserPriority(priority);
    _boxLists.put('itemListKey', itemList);
    notifyListeners();
  }

// ADD ITEM
  Future<void> setData(int toIdentify, dynamic value) async {
    await _box.put(toIdentify, value);

    notifyListeners();
  }

//SHOPPING LIST
  /*  final List<Item_Model> _shoppingList = [];
  List<Item_Model> get shoppingList => _shoppingList; */

  void addToShoppingList(Item_Model item, int index) {
    Item_Model updatedItem = item.copyWith(isInShoppingCart: true);
    _box.putAt(index, updatedItem);
    item.isInShoppingCart = true;
    notifyListeners();
  }

//ESSENTIAL AND OPTIONAL LIST
  List<Item_Model> get essentials => _box.values
      .where((item) =>
          item is Item_Model &&
          item.priority == "Essential" &&
          item.isInShoppingCart == true)
      .cast<Item_Model>()
      .toList();

  List<Item_Model> get optionals => _box.values
      .where((item) =>
          item is Item_Model &&
          item.priority == "Optional" &&
          item.isInShoppingCart == true)
      .cast<Item_Model>()
      .toList();

  void _onBoxUpdated() {
    notifyListeners();
  }

// CHAGE QUANITY
  void changeQuantityOfShoppingItem(Item_Model item, int index, int quantity) {
    Item_Model newItem =
        _box.values.firstWhere((storedItem) => storedItem.name == item.name);
    newItem.quantitytoBuy = quantity;
    _box.putAt(index, newItem);

    notifyListeners();
  }

//DISPOSERS
  @override
  void dispose() {
    _box.listenable().removeListener(_onBoxUpdated);

    super.dispose();
  }

  //LIST FILTERING
  void filteredList(String? location) {
    if (location == "All") {
      filteredItems = _box.values.cast<Item_Model>().toList();
    } else {
      filteredItems = _box.values
          .where((item) => item.location == location)
          .cast<Item_Model>()
          .toList();
    }
    notifyListeners();
  }

  //DeLETEITEM
  void delete(int index) {
    getBox.deleteAt(index);
  }

  //ADD ID¨
  int getNextId(Box box) {
    if (!box.containsKey('currentId')) {
      box.put('currentId', 0); // Initialize if missing
    }
    int currentId = box.get('currentId')! as int;
    box.put('currentId', currentId + 1);
    return currentId;
  }

  // REMOVE FROM SHOPPING CART
  void deleteFromShoppingList(Item_Model item, int index) {
    Item_Model updatedItem =
        item.copyWith(isInShoppingCart: false, quantitytoBuy: 0);
    _box.putAt(index, updatedItem);
    item.isInShoppingCart = true;
    notifyListeners();
  }
}
