import 'dart:io';
import 'package:excel/excel.dart';

Future<void> readExcel() async {
  var file = "./assets/shoppingalls.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    print(table); // Sheet name
    print(excel.tables[table]?.maxColumns);
    print(excel.tables[table]?.maxRows);

    // Accessing row data
    for (var row in excel.tables[table]?.rows ?? []) {
      print('$row');
    }
  }
}

void main(List<String> args) {
  readExcel();
}
