import 'package:fitness/db/boxes.dart';
import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/item_static_properties.dart';
import 'package:fitness/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(ItemlistAdapter());
  boxItems = await Hive.openBox<Item_Model>("itemBox");
  boxLists = await Hive.openBox<Item_list>("itemListsBox");

  runApp(ChangeNotifierProvider(
      create: (_) => HiveDataNotifier(boxItems, boxLists),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color(0xffFF6315),
          primaryColorLight: const Color.fromARGB(255, 255, 183, 147),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xffFF6315),
          )),
      home: const HomePage(),
    );
  }
}
