import 'package:flutter/material.dart';
import 'package:rentapp/Screens/Room/add_room.dart';
import 'package:rentapp/Screens/user/user_list.dart';

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
          title: const Text('Home'),
          bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.grey,
              indicatorWeight: 5,
              labelColor: Colors.white,
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
            const Occupied(),
            const Paid(),
            const Unpaid(),
          ],
        ),

        //===================================== BottomNavigationBar
        bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.home,
         color: Color.fromARGB(255, 50, 62, 73), 
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.filter_alt_sharp,
          color: Color.fromARGB(255, 50, 62, 73),
        ),
      ),
      const SizedBox(width: 60),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.currency_rupee,
                  color: Color.fromARGB(255, 50, 62, 73), 
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserList()));
        },
        icon: const Icon(
          Icons.people,
           color: Color.fromARGB(255, 50, 62, 73), 
        ),
      ),
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
  //===================================== AddRoom Navigation
  void addRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddRoom(
                tabController: _tabController,
              )),
    );
  }

  
}
