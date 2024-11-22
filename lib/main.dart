import 'package:fitness/db/boxes.dart';
import 'package:fitness/hive/hive_data_notifier.dart';
import 'package:fitness/models/item_model.dart';
import 'package:fitness/models/item_static_properties.dart';
import 'package:fitness/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      color: Color(0xffFF6315),
      alignment: Alignment.center,
      child: Text(
          "Oops, there was a little error :(\n. Please close the dialog box and try again ",
          style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  };

  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(ItemlistAdapter());
  boxItems = await Hive.openBox<Item_Model>("itemBox");
  boxLists = await Hive.openBox<Item_list>("itemListsBox");
  idBox = await Hive.openBox<int>("idBox");

  runApp(ChangeNotifierProvider(
      create: (_) => HiveDataNotifier(boxItems, boxLists, idBox),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
