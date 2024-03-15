import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;

  const UserDetails({required this.userModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Details'),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.edit))],
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
                  const Text(
                    'Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.name,
                    
                    style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Phone Number:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.phoneNumber,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Upload Adhaar:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.uploadAdhaar,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Occupation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.occupation,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Check-in:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.checkin,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Check-out:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.checkout,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Advance Amount:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    userModel.advanceAmount,
                    style: const TextStyle(fontWeight:FontWeight.w500,fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
