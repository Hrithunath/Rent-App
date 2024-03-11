import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:rentapp/model/room_model.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);

//=====================================AddRoom
Future<void> addRoomAsync(RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  final newId = await roomDB.add(value);
  value.id = newId;
  await roomDB.put(value.id, value);
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  roomNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateRoomAsync(EditRoom, id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.put(EditRoom.id, EditRoom);
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  // roomNotifier.notifyListeners();
}

//=====================================GetRoom
Future<void> getRoom() async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  roomNotifier.value.clear();
  roomNotifier.value.addAll(roomDB.values);

  roomNotifier.notifyListeners();
}

Future<void> deleteroom(int id) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.delete(id);
  await getRoom();
  roomNotifier.notifyListeners();
}
