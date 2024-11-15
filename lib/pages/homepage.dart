// ignore_for_file: prefer_const_constructors

import 'package:fitness/pages/inventory_page.dart';
import 'package:fitness/pages/shopping_page.dart';
import 'package:fitness/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(),
        body: TabBarView(children: [InventoryPage(), ShoppingPage()]),
        bottomNavigationBar: SizedBox(
          width: 50,
          child: TabBar(
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(
                  text: "Inventory",
                ),
                Tab(
                  text: "Shopping",
                ),
              ]),
        ),
      ),
    );
  }
}
