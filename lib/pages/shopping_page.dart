// ignore_for_file: prefer_const_constructors

import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/itemlist_model.dart';
import 'package:fitness/widgets/locations_list.dart';
import 'package:fitness/widgets/searchbar.dart';
import 'package:fitness/widgets/shopping_item_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    List<String> locations = Provider.of<ItemlistModel>(context).locationsList;
    List<Item_Model> essentialItems =
        Provider.of<ItemlistModel>(context).essentialList;

    List<Item_Model> optionalItems =
        Provider.of<ItemlistModel>(context).optionalList;
    double totalPrice = Provider.of<ItemlistModel>(context).totalPrice;

    /*  setState(() {
      totalPrice = EssentialTotalPrice + OptionalTotalPrice;
    }); */

    return Scaffold(
      body: Consumer<ItemlistModel>(builder: (context, ItemlistModel, child) {
        return Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 8,
                ),

                //LOCATIONS
                /*  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: LocationsList(locations: locations)), */
                SizedBox(
                  height: 20,
                ),

                // SEARCHBAR
                Searchbar(),
                SizedBox(
                  height: 20,
                ),

                //MAINN BODY
                Column(
                  children: [
                    Text("Essential",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.blue)),
                    SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 32,
                              );
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: essentialItems.length,
                            itemBuilder: (context, index) {
                              return ShoppingItemContainer(
                                  item: essentialItems[index]);
                            })),
                  ],
                ),
                Column(
                  children: [
                    Text("Optional",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.blue)),
                    SizedBox(
                        width: double.infinity,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 32,
                              );
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: optionalItems.length,
                            itemBuilder: (context, index) {
                              return ShoppingItemContainer(
                                  item: optionalItems[index]);
                            })),
                  ],
                ),
                Text("Budget: ${totalPrice}")
              ]),
            ));
      }),
    );
  }
}
