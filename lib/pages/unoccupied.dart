import 'dart:io';

import 'package:flutter/material.dart';

import 'package:rentapp/Screens/Room/edit_room.dart';
import 'package:rentapp/Screens/user/add_userdetails.dart';
import 'package:rentapp/functions/db_room.dart';
import 'package:rentapp/model/room_model.dart';

import '../widgets/refactor_delete.dart';
import '../widgets/refactor_edit.dart';

class Unoccupied extends StatefulWidget {
  final TabController tabController;
  const Unoccupied({super.key, required this.tabController});

  @override
  State<Unoccupied> createState() => _UnoccupiedState();
}

class _UnoccupiedState extends State<Unoccupied> {
  int? id;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<RoomModel>>(
      valueListenable: roomNotifier,
      builder: (BuildContext context, List<RoomModel> roomList, Widget? child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = roomList[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(data.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room No: ${data.room}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Floor: ${data.floor}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Guests: ${data.guests}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Text(
                                  'Bed: ${data.bed}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (data.id != null) {
                                            deleteAlert(context, data.id!);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        if (data.id != null) {
                                          editAlert(context, data.id!, roomList,
                                              index);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color.fromARGB(255, 50, 62, 73),
                                      ),
                                      iconSize: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${data.rent}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddUser(
                                          tabController: widget.tabController,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.currency_rupee,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Rent',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                    elevation:
                                        MaterialStateProperty.all<double>(8),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      const EdgeInsets.all(12),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: roomList.length,
        );
      },
    );
  }

  editAlert(BuildContext context, int id, List<RoomModel> roomList, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EditAlert(onEdit: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditRoom(roomModel: roomList[index])));
          });
        });
  }

  deleteAlert(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(onDelete: () {
            deleteroom(id);
            Navigator.of(context).pop();
          });
        });
  }
}
