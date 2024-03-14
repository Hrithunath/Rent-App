import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';

class User_List extends StatefulWidget {
  const User_List({Key? key}) : super(key: key);

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Details',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<List<UserModel>>(
            valueListenable: userNotifier,
            builder: (BuildContext context, List<UserModel> userList, Widget? child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = userList[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                        radius: 35,
                      ),
                      title: Text('Name: ${data.name}'),
                      subtitle: Text('Phone Number ${data.phoneNumber}'),
                      trailing: Text('CheckIn: ${data.checkin}'),
                    ),
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
