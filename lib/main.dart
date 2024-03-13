import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentapp/Screens/Room/home.dart';
import 'package:rentapp/model/room_model.dart';
import 'package:rentapp/model/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RoomModelAdapter().typeId)) {
    Hive.registerAdapter(RoomModelAdapter());
      print('RoomModelAdapter is now registered.');
  }
 
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
    print('UserModelAdapter is now registered.');
  }

  runApp(const MyApp());
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
        home: const Home());
  }
}
