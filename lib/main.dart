import 'package:fitness/db/boxes.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/itemlist_model.dart';
import 'package:fitness/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  boxItems = await Hive.openBox<Item_Model>("itemBox");

  runApp(ChangeNotifierProvider(
      create: (context) => ItemlistModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}
