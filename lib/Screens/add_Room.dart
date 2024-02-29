import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentapp/Screens/home.dart';

import 'package:rentapp/functions/db_functions.dart';
import 'package:rentapp/model/room_model.dart';
import 'package:rentapp/pages/unoccupied.dart';

class AddRoom extends StatefulWidget {
  AddRoom({super.key, required TabController tabController});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final formkey = GlobalKey<FormState>();

  final roomNoController = TextEditingController();

  final floorController = TextEditingController();

  final guestsController = TextEditingController();

  final bedController = TextEditingController();

  final rentController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? pickedImage;
  String pickedImagePath = '';
  String imgPath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Room Details',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 234, 234),
                    borderRadius: BorderRadius.circular(15),
                    image: imgPath != null
                        ? DecorationImage(
                            image: FileImage(File(imgPath)),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/images/profile.jpg"),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: IconButton(
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 50,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: roomNoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Room No',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Room No Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: floorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Floor',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Floor Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: guestsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Guests',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Guests Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: bedController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Bed',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bed Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: rentController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rent/Month',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Rent Is Required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      AddRoom(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 3, 12, 83),
                      ),
                    ),
                    child: const Text(
                      'ADD ROOM',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        pickedImagePath = pickedFile.path;
        imgPath = pickedImagePath;
      });
    }
  }

  Future<void> AddRoom(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      final room = roomNoController.text.trim();
      final floor = floorController.text.trim();
      final guests = guestsController.text.trim();
      final bed = bedController.text.trim();
      final rent = rentController.text.trim();
      final image = imgPath;
      if (room.isEmpty ||
          floor.isEmpty ||
          guests.isEmpty ||
          bed.isEmpty ||
          rent.isEmpty ||
          imgPath.isEmpty) {
        return;
      }

      final rooms = RoomModel(
          room: room,
          floor: floor,
          guests: guests,
          bed: bed,
          rent: rent,
          image: image);

      addRoom(rooms);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }
}
