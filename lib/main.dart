import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentapp/Screens/home.dart';

import 'package:rentapp/model/room_model.dart';
import 'package:rentapp/pages/unoccupied.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RoomModelAdapter().typeId)) {
    Hive.registerAdapter(RoomModelAdapter());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                color: Color.fromARGB(255, 3, 12, 83),
                titleTextStyle: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        home: Home());
  }
}
