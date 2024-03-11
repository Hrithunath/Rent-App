import 'package:flutter/material.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';

class user_List extends StatefulWidget {
  const user_List({Key? key});

  @override
  State<user_List> createState() => _user_ListState();
}

class _user_ListState extends State<user_List> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
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
            builder: (BuildContext context, List<UserModel> userList, Widget? child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = userList[index];
                  return  Card(
                    child: ListTile(
                      // leading: Image(image: image),
                      title: Text( 'Name: ${data.name}',), 
                      // subtitle: Text('Room NO 345'), 
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
