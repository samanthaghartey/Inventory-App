// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  List<String> list = [];
  final Function(String) onTextChanged;
  TextEditingController new_dropdown_item_controller;
  String? selectedvalue;

  CustomDropdown(
      {super.key,
      required this.list,
      required this.onTextChanged,
      required this.new_dropdown_item_controller,
      required this.selectedvalue});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  void initState() {
    super.initState();
    widget.new_dropdown_item_controller.text = widget.selectedvalue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 90,
          child: TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  hintText: widget.selectedvalue,
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor))),
              controller: widget.new_dropdown_item_controller,
              onSubmitted: widget.onTextChanged),
        ),
        DropdownButton<String>(
            value: widget.selectedvalue,
            items: widget.list.map((listItem) {
              return DropdownMenuItem(value: listItem, child: Text(listItem));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.selectedvalue = newValue;

                widget.new_dropdown_item_controller.text = newValue ?? "";
              });
              if (newValue != null) {
                widget.onTextChanged(newValue);
              }
            }),
      ],
    );
  }
}
