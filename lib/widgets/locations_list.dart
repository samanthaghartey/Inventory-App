// ignore_for_file: prefer_const_constructors

import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationsList extends StatefulWidget {
  final List<String> locations;
  const LocationsList({super.key, required this.locations});

  @override
  State<LocationsList> createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    bool showAll = selectedIndex == -1;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<HiveDataNotifier>(context, listen: false)
                .filteredList("All");
            setState(() {
              selectedIndex = -1;
            });
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                color: showAll ? Theme.of(context).primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  if (!showAll)
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        offset: Offset(.5, .5),
                        spreadRadius: .5,
                        blurRadius: 2)
                ]),
            child: Center(
              child: Text(
                "All",
                style: TextStyle(
                    color: showAll ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 40,
                );
              },
              itemCount: widget.locations.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                bool isActive = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    Provider.of<HiveDataNotifier>(context, listen: false)
                        .filteredList(widget.locations[index]);
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          if (!isActive)
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                offset: Offset(.5, .5),
                                spreadRadius: .5,
                                blurRadius: 2)
                        ]),
                    child: Center(
                      child: Text(
                        widget.locations[index],
                        style: TextStyle(
                            color: isActive ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
