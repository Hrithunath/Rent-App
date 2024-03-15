import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentapp/Screens/user/edit_userdetails.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_edit.dart';
import 'package:rentapp/widgets/refactor_text.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;
  final String? imagepath;
  UserDetails({required this.userModel, this.imagepath});

  @override
  Widget build(BuildContext context) {
    int? id = userModel.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Details'),
        actions: [
          IconButton(
            onPressed: () {
              if (id != null) {
                editAlert(context, id);
              }
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 550,
          child: Card(
            elevation: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(userModel.image)),
                  ),
                  const SizedBox(height: 20),
                  customText('Name', userModel.name, null),
                  const SizedBox(height: 10),
                  customText('Phone Number', userModel.phoneNumber, null),
                  const SizedBox(height: 10),
                  customText(
                    'UploadAdhaar',
                    userModel.uploadAdhaar,
                    IconButton(
                      onPressed: () {
                        showUploadAdhaar(context, userModel.uploadAdhaar);
                      },
                      icon: const Icon(Icons.image_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  customText('Occupation', userModel.occupation, null),
                  const SizedBox(height: 10),
                  customText('CheckIn', userModel.checkin, null),
                  const SizedBox(height: 10),
                  customText('CheckOut', userModel.checkout, null),
                  const SizedBox(height: 10),
                  customText('Advance Amount', userModel.advanceAmount, null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showUploadAdhaar(BuildContext context, String imagePath) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Image'),
          content: SizedBox(
            width: 200,
            height: 200,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  editAlert(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return EditAlert(
          onEdit: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditUser(userModel: userModel),
              ),
            );
          },
        );
      },
    );
  }
}
