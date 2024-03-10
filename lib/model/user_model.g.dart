// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsAdapter extends TypeAdapter<UserDetails> {
  @override
  final int typeId = 2;

  @override
  UserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetails(
      id: fields[0] as int?,
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      uploadAdhaar: fields[3] as String,
      checkin: fields[4] as String,
      checkout: fields[5] as String,
      advanceAmount: fields[6] as String,
      image: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetails obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.uploadAdhaar)
      ..writeByte(4)
      ..write(obj.checkin)
      ..writeByte(5)
      ..write(obj.checkout)
      ..writeByte(6)
      ..write(obj.advanceAmount)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
