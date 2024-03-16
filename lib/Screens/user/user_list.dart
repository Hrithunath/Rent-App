import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentapp/Screens/user/user_details.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_text.dart';

class UserList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const UserList({Key? key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
          title: const Text('User List'),
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
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => UserDetails(userModel: data)));
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.image)),
                        radius: 35,
                      ),
                      title: Row(
                        children: [

                           //===================================== Name
                          customText('Name', data.name, null),
                       ],
                      ),
                      subtitle: Row(
                        children: [

                           //===================================== PhoneNumber
                          customText('Phone number', data.phoneNumber, null),
                        ],
                      ),
                    ),
                  );
                },
                
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
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
