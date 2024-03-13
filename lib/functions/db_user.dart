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

Future<void> getuser() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userNotifier.value.clear();
  userNotifier.value.addAll(userDB.values);
  userNotifier.notifyListeners();
}
