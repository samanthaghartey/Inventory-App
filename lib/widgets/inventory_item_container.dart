// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fitness/models/item_model.dart';
import 'package:fitness/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final Item_Model item;
  final VoidCallback addToCart;
  final VoidCallback deleteItem;
  int? index;
  ItemContainer(
      {super.key,
      required this.item,
      required this.addToCart,
      required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogBox(
                item: item,
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                quantitytoBuy: item.quantitytoBuy,
                selectedlocation: item.location,
                selectedpriority: item.priority,
                index: item.id,
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(.3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Text("${item.quantity}pcs"),
                  Text(item.location)
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onPressed: addToCart,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          const Text("Add"),
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  /*  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogBox(
                                item: item,
                                name: item.name,
                                toIdentify: item.name,
                                price: item.price,
                                quantity: item.quantity,
                                quantitytoBuy: item.quantitytoBuy,
                                selectedlocation: item.location,
                                selectedpriority: item.priority,
                                index: index,
                              );
                            });
                      },
                      child: const Text("Edit")), */
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: deleteItem,
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
