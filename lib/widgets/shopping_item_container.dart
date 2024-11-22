// ignore_for_file: prefer_const_constructors

import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/widgets/dialog_box.dart';
import 'package:fitness/widgets/quantity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingItemContainer extends StatefulWidget {
  final Item_Model item;

  ShoppingItemContainer({super.key, required this.item});

  @override
  State<ShoppingItemContainer> createState() => _ShoppingItemContainerState();
}

class _ShoppingItemContainerState extends State<ShoppingItemContainer> {
  final TextEditingController quantityController = TextEditingController();

  void deleteFromShoppingList(Item_Model item) {
    Provider.of<HiveDataNotifier>(context, listen: false)
        .deleteFromShoppingList(item, item.id);
  }

  @override
  Widget build(BuildContext context) {
    int quantity = widget.item.quantitytoBuy;

    double price = widget.item.price;
    void changeQuantity(String? operation) {
      setState(() {
        if (operation == "+") {
          quantity += 1;
        } else if (operation == "-" && quantity > 0) {
          quantity -= 1;
        }
      });
      Provider.of<HiveDataNotifier>(context, listen: false)
          .changeQuantityOfShoppingItem(widget.item, widget.item.id, quantity);
    }

    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogBox(
                item: widget.item,
                name: widget.item.name,
                price: widget.item.price,
                quantity: widget.item.quantity,
                quantitytoBuy: widget.item.quantitytoBuy,
                selectedlocation: widget.item.location,
                selectedpriority: widget.item.priority,
                index: widget.item.id,
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 90,
                      child: Text(
                        widget.item.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      )),
                  Text(
                    "You have ${widget.item.quantity} in stock",
                  ),
                ],
              ),
              Quantity(
                  quantity: quantity,
                  quantityController: quantityController,
                  changeQuantity: changeQuantity),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    offset: Offset(.5, .5),
                                    spreadRadius: .5,
                                    blurRadius: 2)
                              ]),
                          child: Text(
                            "${quantity * price}kr",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      style: IconButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      ),
                      onPressed: () => deleteFromShoppingList(widget.item),
                      icon: /* Text(
                    "Remove Item",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 13,
                    ),
                  ) */
                          Icon(
                        Icons.remove_shopping_cart,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
