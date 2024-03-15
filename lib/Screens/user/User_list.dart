import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentapp/Screens/user/user_details.dart';
import 'package:rentapp/functions/db_user.dart';
import 'package:rentapp/model/user_model.dart';
import 'package:rentapp/widgets/refactor_text.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User List')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<List<UserModel>>(
            valueListenable: userNotifier,
            builder: (BuildContext context, List<UserModel> userList, Widget? child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = userList[index];

                  return Expanded(
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                      child: ListTile(
                        onTap: (){Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) =>  UserDetails(userModel: data)));},
                        leading: CircleAvatar(
                          backgroundImage: FileImage(File(data.image)),
                          radius: 35,
                        ),
                        title: Row(
                          children: [
                           
                             customText('Name', data.name,null),

                           const SizedBox(width: 30,),
                            Text('CheckIn ${data.checkin}'),
                    
                          ],
                        ),
                      
                        subtitle: Row(
                          children: [
                            
                             customText('Phone number', data.phoneNumber,null),
                          ],
                        ),
                       
                      ),
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
