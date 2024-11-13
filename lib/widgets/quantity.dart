// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Quantity extends StatelessWidget {
  int quantity;
  final TextEditingController quantityController;
  Function(String) changeQuantity;
  Quantity(
      {super.key,
      required this.quantity,
      required this.quantityController,
      required this.changeQuantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(.5),
            offset: Offset(.5, .5),
            spreadRadius: .5,
            blurRadius: 2)
      ]),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: Color(0xffFF6315),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4))),
            child: Center(
              child: IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    changeQuantity("-");
                  },
                  iconSize: 15,
                  icon: Icon(Icons.remove)),
            ),
          ),
          SizedBox(
              width: 50,
              child: TextField(
                textAlign: TextAlign.center,
                controller: quantityController..text = quantity.toString(),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none),
              )),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: Color(0xffFF6315),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4))),
            child: Center(
              child: IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    changeQuantity("+");
                  },
                  iconSize: 15,
                  icon: Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }
}
