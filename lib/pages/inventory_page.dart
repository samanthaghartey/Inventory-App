// ignore_for_file: prefer_const_constructors

import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/itemlist_model.dart';
import 'package:fitness/widgets/add_button.dart';
import 'package:fitness/widgets/inventory_item_container.dart';
import 'package:fitness/widgets/locations_list.dart';
import 'package:fitness/widgets/searchbar.dart';
import 'package:flutter/material.dart';
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
    //Fetch itemlist from provider
    List<Item_Model> itemlist =
        Provider.of<ItemlistModel>(context).filteredItems;
    List<String> locations = Provider.of<ItemlistModel>(context).locationsList;

    void addToCart(Item_Model item) {
      List<Item_Model> shoppingList =
          Provider.of<ItemlistModel>(context, listen: false).shoppingItems;
      if (!shoppingList.contains(item)) {
        Provider.of<ItemlistModel>(context, listen: false)
            .addtoShoppingList(item);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ItemlistModel>(builder: (context, ItemlistModel, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: LocationsList(locations: locations)),
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
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 32,
                            );
                          },
                          itemCount: itemlist.length,
                          itemBuilder: (context, index) {
                            return ItemContainer(
                              item: itemlist[index],
                              index: index,
                              addToCart: () => addToCart(itemlist[index]),
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
