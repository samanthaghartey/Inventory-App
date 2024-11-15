// ignore_for_file: prefer_const_constructors

import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/widgets/add_button.dart';
import 'package:fitness/widgets/inventory_item_container.dart';
import 'package:fitness/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    void addToCart(Item_Model item) {
      Provider.of<HiveDataNotifier>(context, listen: false)
          .addToShoppingList(item, item.id);
    }

    void deleteItem(int index) {
      Provider.of<HiveDataNotifier>(context, listen: false).delete(index);
    }

    //get box conaining all items
    Box box = Provider.of<HiveDataNotifier>(context, listen: false).getBox;
    List<String> locations =
        Provider.of<HiveDataNotifier>(context, listen: false).locations;

    return Scaffold(
        backgroundColor: Colors.white,
        body:
            Consumer<HiveDataNotifier>(builder: (context, hiveNotifier, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                /* SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: LocationsList(locations: locations)), */
                SizedBox(
                  height: 20,
                ),
                Searchbar(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child: ListView.separated(
                          reverse: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 32,
                            );
                          },
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            return ItemContainer(
                              item: box.getAt(index),
                              deleteItem: () => deleteItem(index),
                              index: index,
                              addToCart: () => addToCart(box.getAt(index)),
                            );
                          })),
                ),
                SizedBox(
                  height: 30,
                ),
                AddButton()
              ],
            ),
          );
        }));
  }
}
