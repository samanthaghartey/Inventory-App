// ignore_for_file: prefer_const_constructors

import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';

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
    List<Item_Model> essentialItems =
        Provider.of<HiveDataNotifier>(context).essentials;

    List<Item_Model> optionalItems =
        Provider.of<HiveDataNotifier>(context).optionals;

    double totalPrice =
        Provider.of<HiveDataNotifier>(context, listen: false).totalCost();

    return Scaffold(
      body: Consumer<HiveDataNotifier>(
          builder: (context, hiveDataNotifier, child) {
        return Padding(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
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
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme.of(context).primaryColor,
                          ),
                          width: 200,
                          child: Center(
                            child: Text("Essential Items",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: essentialItems.isEmpty
                                ? noItemWidget()
                                : ListView.separated(
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
                                          index: essentialItems[index].id,
                                          item: essentialItems[index]);
                                    })),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme.of(context).primaryColor,
                          ),
                          width: 200,
                          child: Center(
                            child: Text("Optional Items",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: optionalItems.isEmpty
                                ? noItemWidget()
                                : ListView.separated(
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
                                          index: optionalItems[index].id,
                                          item: optionalItems[index]);
                                    })),
                      ],
                    ),
                  ]),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: Offset(.5, .5),
                                spreadRadius: .5,
                                blurRadius: 2)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        "Total Cost: $totalPrice kr",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ));
      }),
    );
  }
}

class noItemWidget extends StatelessWidget {
  const noItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Center(child: Text("No items yet")),
    );
  }
}
