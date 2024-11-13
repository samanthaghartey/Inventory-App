import 'package:fitness/models/item_model.dart';
import 'package:fitness/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final Item_Model item;
  final VoidCallback addToCart;
  int? index;
  ItemContainer(
      {super.key, required this.item, required this.addToCart, this.index});

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                Text("${item.quantity}pcs"),
                Text(item.location)
              ],
            ),
            ElevatedButton(onPressed: addToCart, child: const Text("Add")),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogBox(
                          name: item.name,
                          price: item.price,
                          quantity: item.quantity,
                          selectedlocation: item.location,
                          selectedpriority: item.priority,
                          index: index,
                        );
                      });
                },
                child: const Text("Edit")),
          ],
        ),
      ),
    );
  }
}
