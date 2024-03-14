import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/Screens/User_list.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_button.dart';
import 'package:rentapp/widgets/refactor_calender.dart';
import 'package:rentapp/widgets/refactor_text_feild.dart';

class AddUser extends StatefulWidget {
  final UserModel? userModel;
  const AddUser({
    super.key,
    this.userModel,
    required TabController tabController,
  });

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
          horizontal: 5,
          vertical: 7,
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
                            : const AssetImage("assets/images/profile.jpg")
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(
                      height:10,
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
                    // const SizedBox(
                    //   height:1,
                    // ),
                    //===================================== Phone Number
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
                    // const SizedBox(
                    //   height:10,
                    // ),
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
                    // const SizedBox(
                    //   height:10,
                    // ),
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
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    //===================================== CheckIn
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        )),

                        // const SizedBox(
                        //   width: 12,
                        // ),

                        //===================================== CheckOut
                        Expanded(
                            child:
                                //  customtextFeildcalender(
                                //     controller: checkOutController,
                                //     onTapcalender: () {
                                //       selectedCheckedOut(context);
                                //     },
                                //     labeltext: 'CheckOut',
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return 'CheckOut is Required';
                                //       }
                                //       return null;
                                //     },
                                //     autovalidateMode:
                                //         AutovalidateMode.onUserInteraction)
                                TextFormField(
                          controller: checkOutController,
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
                        )),
                      ],
                    ),

                    // const SizedBox(
                    //   height: 10,
                    // ),

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

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    //===================================== Save Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                            buttonText: 'Save',
                            buttonPressed: () {
                              if (formkey.currentState!.validate()) {
                                addUser(context);
                              }
                            })
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

  //===================================== CheckIn Function
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
  //===================================== CheckOut Function

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

  //===================================== PickImage Function
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

  //===================================== AddUser Function
  Future<void> addUser(BuildContext context) async {
    final name = nameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();
    final uploadAdhaar = uploadAdhaarController.text.trim();
    final occupation = occupationController.text.trim();
    final checkin = checkInController.text.trim();
    final checkout = checkOutController.text.trim();
    final advanceAmount = advanceAmounntController.text.trim();
    final image = imgPath;
    print('$image');
    if (name.isEmpty ||
        phoneNumber.isEmpty ||
        uploadAdhaar.isEmpty ||
        occupation.isEmpty ||
        checkin.isEmpty ||
        checkout.isEmpty ||
        image.isEmpty) {
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

    await addUserAsync(addUser);
    print(' user $addUser');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const User_List()));
  }
}
