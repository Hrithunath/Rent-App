import 'package:flutter/material.dart';

class DeleteAlert extends StatelessWidget {
  final void Function() onDelete;
  const DeleteAlert({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('Do you want to Delete ?'),
      actions: [
        TextButton(onPressed: onDelete, child: Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'))
      ],
    );
  }
}
