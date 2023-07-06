import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/DashboardAppBar.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/screens/create/DashboardCreateScreen.dart';

import 'package:myapplication/src/features/dashboard/screens/home/DashboardHomeScreen.dart';
import 'package:myapplication/src/features/dashboard/screens/message/MessagingScreen.dart';
import 'package:myapplication/src/features/dashboard/screens/search/DashboardSearchScreen.dart';

// ignore: must_be_immutable
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
    const DashboardHomeScreen(),
    const DashboardSearchScreen(),
    const MessagingScreen(),
    const DashboardCreateScreen(),
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
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
        elevation: 5,
        shadowColor: primaryColor500.withOpacity(0.1),
        backgroundColor: Colors.white,
        flexibleSpace: const DashboardAppBar(),
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
          unselectedItemColor: const Color.fromARGB(172, 143, 138, 138),
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
