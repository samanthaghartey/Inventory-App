import 'package:fitness/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xffFF6315)),
            iconColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(const EdgeInsets.all(20))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogBox();
              });
        },
        label: const Icon(Icons.add));
  }
}
