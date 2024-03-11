import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/widgets/refactor_text_feild.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

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
                  const CircleAvatar(
                    radius: 70,
                    // backgroundImage:,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //===================================== Name
                  customTextfeild(
                      controller: nameController,
                      keyboardTYpe: TextInputType.number,
                      labelText: 'name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),

                  const SizedBox(
                    height: 20,
                  ),

                  //===================================== Phone Number
                  customTextfeild(
                      controller: phoneNumberController,
                      keyboardTYpe: TextInputType.number,
                      labelText: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),

                  const SizedBox(
                    height: 20,
                  ),

                  //===================================== Upload Adhaar
                  customTextfeild(
                      controller: uploadAdhaarController,
                      keyboardTYpe: TextInputType.number,
                      labelText: 'Upload Adhaar',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Upload Adhaar is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),

                  const SizedBox(
                    height: 20,
                  ),

                  //===================================== Occupation
                  customTextfeild(
                      controller: occupationController,
                      keyboardTYpe: TextInputType.name,
                      labelText: 'Occupation',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Occupation is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),

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
                              suffixIcon: const Icon(Icons.calendar_month)),

                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Check in is Required';
                          //   } else {
                          //     return null;
                          //   }
                          // // },
                          // autovalidateMode:
                          //     AutovalidateMode.onUserInteraction
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
                              suffixIcon: const Icon(Icons.calendar_month)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: advanceAmounntController,
                      decoration: InputDecoration(
                          labelText: 'Advance Amount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Advance Amount is Required';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => home()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 3, 12, 83),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<void> selectedCheckedIN(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));
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
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2100));

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
}
