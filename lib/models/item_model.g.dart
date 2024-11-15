// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<Item_Model> {
  @override
  final int typeId = 1;

  @override
  Item_Model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item_Model(
      name: fields[0] as String,
      quantity: fields[1] as int,
      price: fields[3] as double,
      location: fields[4] as String,
      priority: fields[5] as String,
      type: fields[6] as String,
      id: fields[7] as int,
      isInShoppingCart: fields[9] as bool,
      quantitytoBuy: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Item_Model obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.quantitytoBuy)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.isInShoppingCart)
      ..writeByte(8)
      ..write(obj.priceToBuy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
