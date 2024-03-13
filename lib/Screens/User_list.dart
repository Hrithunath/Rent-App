

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';

class User_List extends StatefulWidget {
  const User_List({super.key});

  @override
  State<User_List> createState() => _User_ListState();
}

class _User_ListState extends State<User_List> {
  
  @override
  void initState() {
    super.initState();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    getuser();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'User Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<List<UserModel>>(
            valueListenable: userNotifier,
            builder: (BuildContext context, List<UserModel> userList,
                Widget? child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = userList[index];

                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(data.image)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'Name: ${data.name}',
                        ),
                        Text('phoneNumber:${data.phoneNumber}')
                        
                      ],
                    ),
                    // subtitle: Text('Room NO 345'),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: userList.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
