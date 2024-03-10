import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentapp/Screens/home.dart';
import 'package:rentapp/model/room_model.dart';
import 'package:rentapp/widgets/refactor_text_feild.dart';

class EditRoom extends StatefulWidget {
  final RoomModel? roomModel;
  final int? id;
  const EditRoom(
      {super.key,
      required TabController tabController,
      this.roomModel,
     this.id, int? roomId});

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
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
  void initState() {
    super.initState();
    if (widget.id != null) {
      roomNoController.text = widget.roomModel!.room;
      floorController.text = widget.roomModel!.floor;
      guestsController.text = widget.roomModel!.guests;
      bedController.text = widget.roomModel!.bed;
      rentController.text = widget.roomModel!.rent;
      imgPath = widget.roomModel!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
           'Edit Room Details' ,
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
                    // ignore: unnecessary_null_comparison
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

                //=====================================Room No
                customTextfeild(
                  controller: roomNoController,
                  keyboardTYpe: TextInputType.number,
                  labelText: 'Room No',
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

                //=====================================Floor
                customTextfeild(
                    controller: floorController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Floor',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Floor Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                const SizedBox(
                  height: 15,
                ),

                //=====================================Guests
                customTextfeild(
                    controller: guestsController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Guests',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Guests Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                const SizedBox(
                  height: 15,
                ),

                //=====================================Bed
                customTextfeild(
                    controller: bedController,
                    keyboardTYpe: TextInputType.name,
                    labelText: 'Bed',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bed Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                const SizedBox(
                  height: 15,
                ),

                //===================================== Rent
                customTextfeild(
                    controller: rentController,
                    keyboardTYpe: TextInputType.number,
                    labelText: 'Rent/Month',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Rent Is Required';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction),

                const SizedBox(
                  height: 15,
                ),

                //=====================================Add or Edit Button
                ElevatedButton(
                    onPressed: () {
                      editRoom(context, widget.id);
                       
                    
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 3, 12, 83),
                      ),
                    ),
                    child: Text(
                    'Save' ,
                      style: const TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

//=====================================PickImage
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

//=====================================Add Room
  Future<void> editRoom(BuildContext context, int? id) async {
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

      final editRooms = RoomModel(
          room: room,
          floor: floor,
          guests: guests,
          bed: bed,
          rent: rent,
          image: image);


 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

}
