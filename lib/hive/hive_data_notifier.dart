import 'package:fitness/db/boxes.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/item_static_properties.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataNotifier extends ChangeNotifier {
  final Box _box;
  final Box _boxLists;
  final Box _idBox;

  HiveDataNotifier(this._box, this._boxLists, this._idBox) {
    _box.listenable().addListener(_onBoxUpdated);
  }

  Item_Model getData(String key) => _box.get(key);

  /// VALUES NEEDED IN APPLICATION

  /// /LOCATION TO TELL THE SEARCH LIST WHAT LOCATION IT SHD SEARCH IN

  String currentLocation = "All";
//Getters
  Box get getBox => _box;
  Box get getBoxList => _box;
  Box get getidBox => _idBox;
  List<Item_Model> get getBoxItems =>
      getBox.values.whereType<Item_Model>().toList();

//GET LOCATIONS AND SORT THEM
  List<String> get locations {
    List<String> list =
        _boxLists.get('itemListKey', defaultValue: Item_list())!.locations;
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  List<String> get userLocations =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!.userLocations;
  Item_list get itemList =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!;

  // GETTER FOR TOTAL PRICE
  double totalCost() {
    List<double> costList = getBoxItems.isEmpty
        ? [0.0]
        : getBoxItems.map((item) => item.quantitytoBuy * item.price).toList();
    return costList.reduce((a, b) => a + b);
  }

//Getter for ItemCount
  int get itemCount =>
      _boxLists.get('itemListKey', defaultValue: Item_list())!.itemCount;

  List<Item_Model> filteredItems = [];

  List<String> get priorities => itemList.priorities;

//ADD LOCATION
  Future<void> addLocation(String location) async {
    await itemList.addUserLocation(location);
    await _boxLists.put('itemListKey', itemList);
    notifyListeners();
  }

  //REMOVE LOCATION
  Future<void> removeLocation(String location) async {
    await itemList.removeUserLocation(location);
    await _boxLists.put('itemListKey', itemList);
    notifyListeners();
  }

  //INCREASET ITEMCOUNT
  int getItemCount() {
    itemList.itemCount += 1;
    _boxLists.put('itemListKey', itemList);

    notifyListeners();
    return itemCount;
  }

//APP PRIORITY
  void addPriority(String priority) {
    itemList.addUserPriority(priority);
    _boxLists.put('itemListKey', itemList);
    notifyListeners();
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

// ADD ITEM
  Future<void> setData(int toIdentify, dynamic value) async {
    await _box.put(toIdentify, value);
    filteredItems = getBoxItems.cast<Item_Model>().toList();

    notifyListeners();
  }

//ADD ITEM TO SHOPPING LIST
  void addToShoppingList(Item_Model item, int index) {
    Item_Model updatedItem = item.copyWith(isInShoppingCart: true);
    _box.put(index, updatedItem);
    item.isInShoppingCart = true;
    notifyListeners();
  }

// CHAGE QUANITY
  void changeQuantityOfShoppingItem(Item_Model item, int index, int quantity) {
    Item_Model newItem = item.copyWith(quantitytoBuy: quantity);

/*     newItem.quantitytoBuy = quantity;
 */
    _box.put(index, newItem);

    notifyListeners();
  }

//ESSENTIAL AND OPTIONAL LIST
  List<Item_Model> get essentials {
    if (currentLocation == "All") {
      return getBoxItems
          .where((item) =>
              item.priority == "Essential" && item.isInShoppingCart == true)
          .cast<Item_Model>()
          .toList();
    } else {
      return getBoxItems
          .where((item) =>
              item.priority == "Essential" &&
              item.location == currentLocation &&
              item.isInShoppingCart == true)
          .cast<Item_Model>()
          .toList();
    }
  }

  List<Item_Model> get optionals {
    if (currentLocation == "All") {
      return getBoxItems
          .where((item) =>
              item.priority == "Optional" && item.isInShoppingCart == true)
          .cast<Item_Model>()
          .toList();
    } else {
      return getBoxItems
          .where((item) =>
              item.priority == "Optional" &&
              item.location == currentLocation &&
              item.isInShoppingCart == true)
          .cast<Item_Model>()
          .toList();
    }
  }

  void _onBoxUpdated() {
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
      filteredItems = getBoxItems.toList();
    } else {
      filteredItems =
          getBoxItems.where((item) => item.location == location).toList();
    }
    currentLocation = location ?? "All";
    notifyListeners();
  }

  //DeLETEITEM
  void delete(int id) {
    getBox.delete(id);
    filteredItems = getBoxItems.cast<Item_Model>().toList();
    notifyListeners();
  }

  // REMOVE FROM SHOPPING CART
  void deleteFromShoppingList(Item_Model item, int index) {
    Item_Model updatedItem =
        item.copyWith(isInShoppingCart: false, quantitytoBuy: 0);
    _box.put(index, updatedItem);
    item.isInShoppingCart = true;
    notifyListeners();
  }

  // SEARCH INVENTOTY
  void searchList(String searchTerm) {
    if (currentLocation == "All") {
      filteredItems = searchTerm == ""
          ? getBoxItems
          : getBoxItems
              .where((item) => item.name.toLowerCase().contains(searchTerm))
              .toList();
    } else {
      filteredItems = searchTerm == ""
          ? getBoxItems
              .where((item) => item.location == currentLocation)
              .toList()
          : getBoxItems
              .where((item) =>
                  item.name.toLowerCase().contains(searchTerm) &&
                  item.location == currentLocation)
              .toList();
    }

    notifyListeners();
  }
}
