import 'package:flutter/material.dart';
import 'package:rentapp/Screens/add_room.dart';

import 'package:rentapp/functions/db_room.dart';

import 'package:rentapp/pages/occupied.dart';
import 'package:rentapp/pages/paid.dart';
import 'package:rentapp/pages/unoccupied.dart';
import 'package:rentapp/pages/unpaid.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? id;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getRoom();
  }

  @override
  Widget build(BuildContext context) {
    getRoom();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: const [
                Tab(text: 'Unoccupied '),
                Tab(text: 'Occupied'),
                Tab(text: 'paid'),
                Tab(text: 'Unpaid'),
              ]),
        ),

        //===================================== TabBarView
        body: TabBarView(
          controller: _tabController,
          children: [
            Unoccupied(tabController: _tabController),
            const occupied(),
            const paid(),
            const unpaid(),
          ],
        ),

        //===================================== BottomNavigationBar
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.filter_alt_sharp)),
              const SizedBox(
                width: 60,
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.currency_rupee)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.people)),
            ],
          ),
        ),

        //===================================== FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () => addRoom(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void addRoom() {
    // print('ID value: $id');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddRoom(
                tabController: _tabController,
              )),
    );
  }

  
}
