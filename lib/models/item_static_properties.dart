// I am keeping the locations and total prices here since they are static properties and cannot be kept by Hive

import 'package:fitness/models/item_model.dart';
import 'package:hive_flutter/adapters.dart';

part 'item_static_properties.g.dart';

@HiveType(typeId: 2)
class Item_list {
  @HiveField(0)
  final List<String> _defaultLocations = ["Fridge", "Freezer", "Bathroom"];
  @HiveField(1)
  final List<String> _priorities = ["Essential", "Optional"];
  @HiveField(2)
  List<String> _userLocations = [];
  @HiveField(3)
  int _itemCount = 0; // to be given as key to every newly created object

  List<String> get locations => _userLocations + _defaultLocations;
  List<String> get priorities => _priorities;
  List<String> get userLocations => _userLocations;
  int get itemCount => _itemCount;

  Future<void> addUserLocation(String location) async {
    if (!locations.contains(location)) {
      _userLocations.add(location);
    }
  }

  Future<void> removeUserLocation(String location) async {
    _userLocations.remove(location);
  }

  void addUserPriority(String priority) {
    if (!_priorities.contains(priority)) {
      _priorities.add(priority);
    }
  }

  set itemCount(int newCount) {
    _itemCount = newCount;
  }
}
