import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Inventory",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      elevation: 4,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Sets the height of the AppBar
}
