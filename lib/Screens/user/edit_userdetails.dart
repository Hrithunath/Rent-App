import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/Screens/user/user_details.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_button.dart';
import 'package:rentapp/widgets/refactor_calender.dart';
import 'package:rentapp/widgets/refactor_delete.dart';
import 'package:rentapp/widgets/refactor_text_feild.dart';

class EditUser extends StatefulWidget {
  final UserModel? userModel;

  const EditUser({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
  String imgPath = '';

  @override
  void initState() {
    super.initState();

    nameController.text = widget.userModel!.name;
    phoneNumberController.text = widget.userModel!.phoneNumber;
    uploadAdhaarController.text = widget.userModel!.uploadAdhaar;
    occupationController.text = widget.userModel!.occupation;
    checkInController.text = widget.userModel!.checkin;
    checkOutController.text = widget.userModel!.checkout;
    advanceAmounntController.text = widget.userModel!.advanceAmount;
    imgPath = widget.userModel!.image;
  }

  @override
  Widget build(BuildContext context) {
    int? id = widget.userModel!.id;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit User Details')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                            : const AssetImage("assets/images/profile.jpg")
                            as ImageProvider
                      ),
                    ),
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
                    customTextfeild(
                      controller: phoneNumberController,
                      keyboardTYpe: TextInputType.phone,
                      labelText: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is Required';
                        } else if (!RegExp(r"^(?:\+91)?[0-9]{10}$")
                            .hasMatch(value)) {
                          return 'Enter Valid Mobile number';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: uploadAdhaarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Upload Adhaar',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              UploadAdhaar();
                            },
                            child: Icon(Icons.upload_file),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Upload Adhaar is Required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
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
                    Row(
                      children: [
                        Expanded(
                          child: customtextFeildcalender(
                            controller: checkInController,
                            onTapcalender: () {
                              selectedCheckedIN(context);
                            },
                            labeltext: 'Check In',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CheckIn is Required';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                              controller: checkOutController,
                              keyboardType: TextInputType.none,
                              onTap: () {
                                selectedCheckedOut(context);
                              },
                              decoration: InputDecoration(
                                labelText: 'Check Out',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(Icons.calendar_month),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                          buttonText: 'Delete',
                          buttonPressed: () {
                            if (id != null) {
                              deleteAlert(context, id);
                            }
                          },
                        ),
                        SizedBox(width: 10),
                        button(
                          buttonText: 'Save',
                          buttonPressed: () {
                            editUser(context, id);
                          },
                        ),
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
        seletedCheckoutDate = null;
        checkOutController.text = "Indefinite";
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        imgPath = pickedFile.path;
      });
    }
  }

  Future<void> UploadAdhaar() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        imgPath = pickedFile.path;
      });
    }
  }

  Future<void> editUser(BuildContext context, int? id) async {
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
          image.isEmpty) {
        return;
      }

      final editUser = UserModel(
        name: name,
        phoneNumber: phoneNumber,
        uploadAdhaar: uploadAdhaar,
        occupation: occupation,
        checkin: checkin,
        checkout: checkout,
        advanceAmount: advanceAmount,
        image: image,
      );

      await updateUserAsync(editUser, id);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserDetails(userModel: editUser)),
      );
    }
  }

  deleteAlert(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return DeleteAlert(
          onDelete: () {
            deleteuser(id);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
