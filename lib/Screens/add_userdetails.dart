import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/Screens/user_list.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_button';
import 'package:rentapp/widgets/refactor_text_feild.dart';

class AddUser extends StatefulWidget {
  final UserModel? userModel;
  final int? id;
  const AddUser({super.key, this.userModel, this.id, required TabController tabController, });

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final formkey = GlobalKey<FormState>();
  
  final nameController = TextEditingController();
  
  final phoneNumberController = TextEditingController();
  
  final uploadAdhaarController = TextEditingController();
  
  final occupationController = TextEditingController();
  
  final checkInController = TextEditingController();
  
  final checkOutController = TextEditingController();
  
  final advanceAmounntController = TextEditingController();
  
  DateTime? seletedCheckInDate;
  DateTime? seletedCheckoutDate;

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
            'Add User Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: pickedImage != null
                            ? FileImage(pickedImage!)
                            : AssetImage("assets/images/profile.jpg")
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //===================================== Name
                    customTextfeild(
                      controller: nameController,
                      keyboardTYpe: TextInputType.text,
                      labelText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //===================================== Phone Number
                    customTextfeild(
                      controller: phoneNumberController,
                      keyboardTYpe: TextInputType.phone,
                      labelText: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //===================================== Upload Adhaar
                    customTextfeild(
                      controller: uploadAdhaarController,
                      keyboardTYpe: TextInputType.text,
                      labelText: 'Upload Adhaar',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Upload Adhaar is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //===================================== Occupation
                    customTextfeild(
                      controller: occupationController,
                      keyboardTYpe: TextInputType.text,
                      labelText: 'Occupation',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Occupation is Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              selectedCheckedIN(context);
                            },
                            controller: checkInController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Check in',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              selectedCheckedOut(context);
                            },
                            controller: checkOutController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Check out',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //===================================== Advance Amount
                    customTextfeild(
                        controller: advanceAmounntController,
                        keyboardTYpe: TextInputType.number,
                        labelText: 'Advance Amount',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Advance Amount is Required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(buttonText: 'save',buttonPressed: () {addUser(context, widget.id);})
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectedCheckedIN(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        seletedCheckInDate = pickedDate;
        checkInController.text = DateFormat.yMd().format(pickedDate);
      });
    } else {
      print('No data range selected');
    }
  }

  Future<void> selectedCheckedOut(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        seletedCheckoutDate = pickedDate;
        checkOutController.text = DateFormat.yMd().format(pickedDate);
      });
    } else {
      setState(() {
        seletedCheckoutDate = DateTime.now();
        checkOutController.text = DateFormat.yMd().format(DateTime.now());
      });
    }
  }

  //===================================== PickImage function
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        pickedImagePath = pickedFile.path;
      });
    }
  }

  //===================================== Add user
  Future<void> addUser(BuildContext context, int? id) async {
    if (formkey.currentState!.validate()) {
      final name = nameController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();
      final uploadAdhaar = uploadAdhaarController.text.trim();
      final occupation = occupationController.text.trim();
      final checkin = checkInController.text.trim();
      final checkout = checkOutController.text.trim();
      final advanceAmount = advanceAmounntController.text.trim();
      final image = imgPath;
      if (name.isEmpty ||
          phoneNumber.isEmpty ||
          uploadAdhaar.isEmpty ||
          occupation.isEmpty ||
          checkin.isEmpty ||
          checkout.isEmpty ||
          imgPath.isEmpty) {
        return;
      }

      final addUser = UserModel(
          name: name,
          phoneNumber: phoneNumber,
          uploadAdhaar: uploadAdhaar,
          occupation: occupation,
          checkin: checkin,
          checkout: checkout,
          advanceAmount: advanceAmount,
          image: image);

      addUserAsync(addUser);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const user_List()));
    }
  }
}
