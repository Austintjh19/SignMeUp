import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/AppBar1.dart';

import 'package:myapplication/src/features/dashboard/screens/home/HomeScreen.dart';
import 'package:myapplication/src/features/dashboard/screens/search/SearchScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List screens = [
    HomeScreen(),
    SearchScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: AppBar1(),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromRGBO(58, 117, 253, 1),
          unselectedItemColor: Color.fromARGB(172, 143, 138, 138),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 25,
          items: const [
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(
                label: 'Search', icon: Icon(Icons.search_outlined)),
            BottomNavigationBarItem(
                label: 'Message', icon: Icon(Icons.message_outlined)),
            BottomNavigationBarItem(
                label: 'Create', icon: Icon(Icons.add_box_outlined)),
          ]),
    );
  }
}
