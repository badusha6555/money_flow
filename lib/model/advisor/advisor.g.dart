// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advisor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetSetterAdapter extends TypeAdapter<BudgetSetter> {
  @override
  final int typeId = 3;

  @override
  BudgetSetter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetSetter(
      category: fields[0] as String?,
      amount: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetSetter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetSetterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
