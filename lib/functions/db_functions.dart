import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentapp/model/room_model.dart';

ValueNotifier<List<RoomModel>> roomNotifier = ValueNotifier([]);

Future<void> addRoom(RoomModel value) async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  await roomDB.add(value);
  roomNotifier.value.add(value);
  roomNotifier.notifyListeners();
}

Future<void> getRoom() async {
  final roomDB = await Hive.openBox<RoomModel>('room_db');
  roomNotifier.value.clear();
  roomNotifier.value.addAll(roomDB.values);
  roomNotifier.notifyListeners();
}
