// ignore_for_file: prefer_const_constructors

import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/itemlist_model.dart';
import 'package:fitness/widgets/custom_dropdown.dart';
import 'package:fitness/widgets/quantity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogBox extends StatefulWidget {
  final String name;
  final String selectedpriority;
  final double price;
  final String selectedlocation;
  final int quantity;
  final int? index;

  DialogBox(
      {super.key,
      this.name = "",
      this.selectedlocation = "Bathroom",
      this.selectedpriority = "Essential",
      this.price = 0,
      this.index,
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
  late int? index;
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController prioritycontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = widget.name;
    selectedpriority = widget.selectedpriority;
    price = widget.price;
    selectedlocation = widget.selectedlocation;
    quantity = widget.quantity;
    index = widget.index;

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
    List<String> locations = Provider.of<ItemlistModel>(context).locationsList;
    List<String> priorities = Provider.of<ItemlistModel>(context).priorityList;

    void onchangeLocation(String location) {
      location = location.replaceFirst(location[0], location[0].toUpperCase());
      Provider.of<ItemlistModel>(context, listen: false).addLocation(location);
      selectedlocation = location;
      locationsController.clear();
    }

    void onchangePriority(String priority) {
      Provider.of<ItemlistModel>(context, listen: false).addpriority(priority);
      selectedpriority = priority;
      prioritycontroller.clear();
    }

    return AlertDialog(
        title: Text("Alert"),
        content: Container(
          padding: EdgeInsets.all(10),
          width: 400,
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NAME BOX
              SizedBox(
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Name of item"),
                    controller: nameController,
                  )),

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

              //PRIORTIY AND DROPDOWN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Priority",
                  ),
                  CustomDropdown(
                      list: priorities,
                      onTextChanged: onchangePriority,
                      new_dropdown_item_controller: prioritycontroller,
                      selectedvalue: selectedpriority),
                ],
              ),

              //QUANTITY
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Quantity"),
                Quantity(
                  quantity: quantity!,
                  quantityController: quantityController,
                  changeQuantity: changeQuantity,
                ),
              ]),

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
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                //if there is no inputed index, add the new item to the item list as usual
                if (index == null) {
                  final newItem = Item_Model(
                      name: nameController.text,
                      quantity: quantity,
                      price: price,
                      location: selectedlocation,
                      priority: selectedpriority);
                  Provider.of<ItemlistModel>(context, listen: false)
                      .addItem(newItem);
                } else // if there is index, update item at that index
                {
                  Provider.of<ItemlistModel>(context, listen: false)
                      .updateItemAtIndex(index!, nameController.text, quantity,
                          price, selectedlocation, selectedpriority);
                }

                Navigator.of(context).pop();
              }
            },
            child: Text(
              "Add Item",
              style: TextStyle(
                color: Color(0xffFF6315),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Close",
                style: TextStyle(
                  color: Color(0xffFF6315),
                )),
          ),
        ]);
  }
}
