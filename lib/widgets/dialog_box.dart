// ignore_for_file: prefer_const_constructors

import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/widgets/custom_dropdown.dart';
import 'package:fitness/widgets/quantity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class DialogBox extends StatefulWidget {
  final String name;

  final String selectedpriority;
  final double price;
  final String selectedlocation;
  final int quantity;
  final int? quantitytoBuy;
  final int? index;
  final Item_Model? item;

  const DialogBox(
      {super.key,
      this.name = "",
      this.item,
      this.selectedlocation = "Bathroom",
      this.selectedpriority = "Essential",
      this.price = 0,
      this.index,
      this.quantitytoBuy,
      this.quantity = 1});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late String name;

  late String selectedpriority;
  late double price;
  late String selectedlocation;
  late int quantity;
  late int? quantitytoBuy;
  late int? index;
  late Item_Model? item;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController prioritycontroller = TextEditingController();

//SHOW SNACKBAR
  void _showSnackBar(BuildContext context, String name) {
    final snackBar = SnackBar(
      content: Text('The item $name is already in your inventory :)'),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    name = widget.name;
    selectedpriority = widget.selectedpriority;
    price = widget.price;
    selectedlocation = widget.selectedlocation;
    quantity = widget.quantity;
    quantitytoBuy = widget.quantitytoBuy;
    index = widget.index;
    item = widget.item;

    nameController.text = name;
    priceController.text = price.toString();
    quantityController.text = quantity.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    locationsController.dispose();
    super.dispose();
  }

  void changeQuantity(String? operation) {
    setState(() {
      if (operation == "+") {
        quantity = quantity + 1;
      } else if (operation == "-" && quantity > 0) {
        quantity = quantity - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> locations = Provider.of<HiveDataNotifier>(context).locations;
    List<String> priorities = Provider.of<HiveDataNotifier>(context).priorities;
    Box idBox = Provider.of<HiveDataNotifier>(context).getidBox;

    List<Item_Model> boxItems =
        Provider.of<HiveDataNotifier>(context).getBoxItems;

    int itemCount = Provider.of<HiveDataNotifier>(context).getNextId(idBox);

    List<String> names =
        boxItems.map((item) => item.name.toLowerCase()).toList();

    void onchangeLocation(String location) {
      location = location.replaceFirst(location[0], location[0].toUpperCase());
      locationsController.text = location;

      Provider.of<HiveDataNotifier>(context, listen: false)
          .addLocation(location);

      setState(() {
        selectedlocation = location;
      });
    }

    void onchangePriority(String priority) {
      Provider.of<HiveDataNotifier>(context, listen: false)
          .addPriority(priority);
      selectedpriority = priority;
      prioritycontroller.clear();
    }

    return AlertDialog(
        title: index == null ? Text("Add Item") : Text("Edit Item"),
        content: Container(
          padding: EdgeInsets.all(5),
          width: 400,
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //NAME BOX
                SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Name of item",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor))),
                      controller: nameController,
                    )),
                SizedBox(
                  height: 10,
                ),

                //LOCATION AND DROPDOWN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Location",
                    ),
                    CustomDropdown(
                        list: locations,
                        onTextChanged: onchangeLocation,
                        new_dropdown_item_controller: locationsController,
                        selectedvalue: selectedlocation)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //PRIORTIY AND DROPDOWN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Priority",
                    ),
                    DropdownButton<String>(
                      iconEnabledColor: Theme.of(context).primaryColor,
                      value: selectedpriority,
                      items: priorities.map((listItem) {
                        return DropdownMenuItem(
                            value: listItem, child: Text(listItem));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedpriority = newValue!;
                          /*                 widget.onTextChanged(newValue!);
                     */
                          prioritycontroller.text = newValue;
                        });
                      },
                    )
                    /*    CustomDropdown(
                        list: priorities,
                        onTextChanged: onchangePriority,
                        new_dropdown_item_controller: prioritycontroller,
                        selectedvalue: selectedpriority), */
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //QUANTITY
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity"),
                      Quantity(
                        quantity: quantity,
                        quantityController: quantityController,
                        changeQuantity: changeQuantity,
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),

                //PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price"),
                    SizedBox(
                        width: 50,
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              labelText: "Price",
                              labelStyle: TextStyle(fontSize: 13)),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              price = double.tryParse(value) ?? 0.0;
                            });
                          },
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Close",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    if (index == null) {
                      if (names.contains(nameController.text)) {
                        _showSnackBar(context, nameController.text);
                      } else {
                        final newItem = Item_Model(
                            id: itemCount,
                            name: nameController.text.replaceFirst(
                                nameController.text[0],
                                nameController.text[0].toUpperCase()),
                            quantity: quantity,
                            price: price,
                            location: selectedlocation,
                            priority: selectedpriority);
                        Provider.of<HiveDataNotifier>(context, listen: false)
                            .setData(itemCount, newItem);
                      }
                    } else {
                      final newItem = Item_Model(
                          isInShoppingCart: item!.isInShoppingCart,
                          id: item!.id,
                          name: nameController.text,
                          quantity: quantity,
                          quantitytoBuy: quantitytoBuy ?? 1,
                          price: price,
                          location: selectedlocation,
                          priority: selectedpriority);
                      Provider.of<HiveDataNotifier>(context, listen: false)
                          .setData(item!.id, newItem);
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Add Item",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}
