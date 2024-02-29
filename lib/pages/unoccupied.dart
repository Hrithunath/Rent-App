import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentapp/functions/db_functions.dart';
import 'package:rentapp/model/room_model.dart';

class unoccupied extends StatelessWidget {
  const unoccupied({super.key});

  @override
  Widget build(BuildContext context) {
    // if(roomNotifier.isEmpty){

    // }
    return ValueListenableBuilder(
      valueListenable: roomNotifier,
      builder: (BuildContext, List<RoomModel> roomlist, Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final data = roomlist[index];
              return Card(
                child: ListTile(
                  leading: Image.file(
                    File(data.image),
                    fit: BoxFit.cover,
                  ),

                  // width: 100,
                  // height: 100,
                  // fit: BoxFit.cover,

                  title: Text(data.room),
                  subtitle: Text(data.floor),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: roomlist.length);
      },
    );
  }
}
