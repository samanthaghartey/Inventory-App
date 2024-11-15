// ignore_for_file: prefer_const_constructors

import 'package:fitness/models/itemlist_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        child: TextField(
          onChanged: (value) {
            Provider.of<ItemlistModel>(context, listen: false)
                .searchList(value);
          },
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(8), // Match the container's radius
                borderSide: BorderSide(color: Colors.grey, width: .5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: .7),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: .7),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: "Search your Inventory",
              hintStyle: TextStyle(color: Colors.black87)),
        ),
      ),
    );
  }
}
