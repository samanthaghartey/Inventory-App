// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_static_properties.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemlistAdapter extends TypeAdapter<Item_list> {
  @override
  final int typeId = 2;

  @override
  Item_list read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item_list().._userLocations = (fields[2] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, Item_list obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._defaultLocations)
      ..writeByte(1)
      ..write(obj._priorities)
      ..writeByte(2)
      ..write(obj._userLocations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
