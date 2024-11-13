// ignore_for_file: prefer_const_constructors

import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/itemlist_model.dart';
import 'package:fitness/widgets/quantity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingItemContainer extends StatefulWidget {
  final Item_Model item;

  const ShoppingItemContainer({super.key, required this.item});

  @override
  State<ShoppingItemContainer> createState() => _ShoppingItemContainerState();
}

class _ShoppingItemContainerState extends State<ShoppingItemContainer> {
  final TextEditingController quantityController = TextEditingController();

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
      Provider.of<ItemlistModel>(context, listen: false)
          .changeQuantityOfShoppingItem(widget.item, quantity);
    }

    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.name),
                Text("You have ${widget.item.quantity} in stock"),
              ],
            ),
            Quantity(
                quantity: quantity,
                quantityController: quantityController,
                changeQuantity: changeQuantity),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
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
                    child: Text("${quantity * price}kr")),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
