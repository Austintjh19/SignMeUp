import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/DashboardAppBar.dart';
import 'package:myapplication/src/features/dashboard/screens/create/CreateEventMainScreen.dart';

import 'package:myapplication/src/features/dashboard/screens/home/HomeScreen.dart';
import 'package:myapplication/src/features/dashboard/screens/search/SearchScreen.dart';

class Dashboard extends StatefulWidget {
  int initialPageIndex;
  Dashboard({super.key, required this.initialPageIndex});
  // const Dashboard({super.key});

  static Dashboard get instance => Get.find();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List screens = [
    const HomeScreen(),
    const SearchScreen(),
    HomeScreen(),
    const CreateEventMainScreen(),
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    if (widget.initialPageIndex != -1) {
      currentPageIndex = widget.initialPageIndex;
      widget.initialPageIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: DashboardAppBar(),
      ),
      body: screens[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: (selectedPageIndex) {
            setState(() {
              currentPageIndex = selectedPageIndex;
            });
          },
          currentIndex: currentPageIndex,
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
