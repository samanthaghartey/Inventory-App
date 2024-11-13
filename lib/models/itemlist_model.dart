import 'package:fitness/models/item_model.dart';
import 'package:flutter/material.dart';

//define change notifeer class
class ItemlistModel extends ChangeNotifier {
  List<Item_Model> items = Item_Model.items;
  List<Item_Model> filteredItems = Item_Model.items;
  List<Item_Model> shoppingItems = [];
  List<String> locationsList = ["Fridge", "Freezer", "Bathroom"];
  List<String> priorityList = ["Essential", "Optional"];

  //prices
  double sum = 0;
  List<Item_Model> get essentialList =>
      items.where((item) => item.priority == "Essential").toList();
  List<Item_Model> get optionalList =>
      items.where((item) => item.priority == "Optional").toList();
  double get essentialTotalPrice =>
      essentialList.fold(0, (sum, item) => sum += item.priceToBuy);
  double get optionalTotalPrice =>
      optionalList.fold(0, (sum, item) => sum += item.priceToBuy);
  double get totalPrice => essentialTotalPrice + optionalTotalPrice;

  void filteredList(String? location) {
    if (location == "All") {
      filteredItems = items;
    } else {
      filteredItems = items.where((item) => item.location == location).toList();
    }

    notifyListeners();
  }

  void searchList(String? searchTerm) {
    filteredItems =
        items.where((item) => item.name.contains(searchTerm!)).toList();
    notifyListeners();
  }

  void addItem(Item_Model item) {
    if (!locationsList.contains(item.location)) {
      addLocation(item.location);
    }
    if (!priorityList.contains(item.priority)) {
      addpriority(item.priority);
    }
    notifyListeners(); //notify widgets to rebuild
  }

  /* quantity: quantity,
                    price: price,
                    location: selectedlocation,
                    priority: selectedpriority*/

  void updateItemAtIndex(int index, String name, int quantity, double price,
      String location, String priority) {
    items[index].name = name;
    items[index].quantity = quantity;
    items[index].price = price;
    items[index].location = location;
    items[index].priority = priority;
    if (!locationsList.contains(location)) {
      addLocation(location);
    }
    if (!priorityList.contains(priority)) {
      addpriority(priority);
    }
    notifyListeners(); //notify widgets to rebuild
  }

  void addLocation(String location) {
    if (!locationsList.contains(location)) {
      locationsList.add(location);
    }
    notifyListeners(); //notify widgets to rebuild
  }

  void addpriority(String priority) {
    if (!priorityList.contains(priority)) {
      priorityList.add(priority);
    }
    notifyListeners(); //notify widgets to rebuild
  }

  void addtoShoppingList(Item_Model item) {
    shoppingItems.add(item);
    notifyListeners();
  }

  void changeQuantityOfShoppingItem(Item_Model item, int quantity) {
    item.quantitytoBuy = quantity;
    notifyListeners();
  }
}
