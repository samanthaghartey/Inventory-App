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
  List<Item_Model> allItems = [];

  @HiveField(2)
  List<String> _userLocations = [];

  List<String> get locations => _defaultLocations + _userLocations;
  List<String> get priorities => _priorities;
  List<String> get userLocations => _userLocations;

  void addUserLocation(String location) {
    if (!locations.contains(location)) {
      _userLocations.add(location);
    }
  }

  void addUserPriority(String priority) {
    if (!_priorities.contains(priority)) {
      _priorities.add(priority);
    }
  }
}
