import 'package:flutter/material.dart';
import 'package:rentapp/Screens/add_Room.dart';
import 'package:rentapp/functions/db_functions.dart';
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
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    getRoom();
  }

  @override
  Widget build(BuildContext context) {
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
              // isScrollable: true,
              tabs: const [
                Tab(text: 'Unoccupied '),
                Tab(text: 'Occupied'),
                Tab(text: 'paid'),
                Tab(text: 'Unpaid'),
              ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            unoccupied(),
            occupied(),
            paid(),
            unpaid(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRoom(
                        tabController: _tabController,
                      )),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
