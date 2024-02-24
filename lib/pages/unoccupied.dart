import 'package:flutter/material.dart';

class Unoccupied extends StatefulWidget {
  const Unoccupied({Key? key}) : super(key: key);

  @override
  State<Unoccupied> createState() => _UnoccupiedState();
}

class _UnoccupiedState extends State<Unoccupied> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'hai',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: const SizedBox(
          height: 300,
          child: Column(
            children: [
              Text('hai'),
            ],
          ),
        ),
      ),
    );
  }
}
