import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentapp/model/room_model.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);

//=====================================AddRoom
Future<void> addRoomAsync(int? id, RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final newId = await roomDB.add(value);
  value.id = newId;
  roomNotifier.value.clear(); // Clear the list before updating
  roomNotifier.value.addAll(roomDB.values);
  roomNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateRoomAsync(int id, RoomModel updatedRoom) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(id, updatedRoom);
  roomNotifier.value.clear(); // Clear the list before updating
  roomNotifier.value.addAll(roomDB.values);
  roomNotifier.notifyListeners();
}

//=====================================GetRoom
Future<void> getRoom() async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  roomNotifier.value.clear();
  roomNotifier.value.addAll(roomDB.values);

  roomNotifier.notifyListeners();
}
