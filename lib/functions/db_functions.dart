import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentapp/model/room_model.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);


//=====================================AddRoom
Future<void> addRoomAsync(RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.add(value);
  print('added set');
  roomNotifier.value.clear();
  roomNotifier.value.add(value);
  roomNotifier.notifyListeners();
}


//=====================================UpdateRoom
Future<void> updateRoomAsync(dynamic key, RoomModel updatedRoom) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(key, updatedRoom);
  roomNotifier.value = roomDB.values.toList();
  roomNotifier.notifyListeners();
}


//=====================================GetRoom
Future<void> getRoom() async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  roomNotifier.value.clear();
  roomNotifier.value.addAll(roomDB.values);

  roomNotifier.notifyListeners();
}
