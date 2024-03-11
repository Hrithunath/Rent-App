import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rentapp/model/user_model.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);


Future<void> addUserAsync(UserModel value) async {
  final roomDB = await Hive.openBox<UserModel>('room_db');
  final newId = await roomDB.add(value);
  value.id = newId;
  await roomDB.put(value.id, value);
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  userNotifier.notifyListeners();
}