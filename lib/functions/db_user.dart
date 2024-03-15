import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rentapp/model/user_model.dart';

ValueNotifier<List<UserModel>> userNotifier = ValueNotifier([]);

Future<void> addUserAsync(UserModel value) async {
  print('enter function');
  final userDB = await Hive.openBox<UserModel>('user_db');
  final userId = await userDB.add(value);
  value.id = userId;
  await userDB.put(value.id, value);
  userNotifier.notifyListeners();
}

//=====================================UpdateRoom
Future<void> updateUserAsync(editUser, id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.put(editUser.id, editUser);
  // roomNotifier.value.clear(); // Clear the list before updating
  // roomNotifier.value.addAll(roomDB.values);
  // roomNotifier.notifyListeners();
}

Future<void> getuser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userNotifier.value.clear();
  userNotifier.value.addAll(userDB.values);
  userNotifier.notifyListeners();
}

//=====================================DeleteUser
Future<void> deleteuser(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.delete(id);
  await getuser();
  userNotifier.notifyListeners();
}