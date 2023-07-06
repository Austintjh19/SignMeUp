import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/features/dashboard/controllers/CurrentUserController.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/NoBookmarkedEventWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/NoRegistredEventWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/AppFunctionsWidget.dart';
import 'package:myapplication/src/common_widgets/HorizontalScrollEventsWidget.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  Future<void> _refreshScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(Dashboard(initialPageIndex: 0));
    return Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final currentUserController = Get.put(CurrentUserController());
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: LiquidPullToRefresh(
          onRefresh: _refreshScreen,
          color: primaryColor100,
          backgroundColor: primaryColor300,
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          height: 200,
          child: ListView(
            children: [
              // App Functions =================================================
              const AppFunctionsWidget(),

              // Your Upcoming Events Text =====================================
              Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                decoration: const BoxDecoration(color: primaryColor100),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Upcoming Events ...",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: textColor500,
                          fontFamily: 'Raleway',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                ),
              ),

              // Upcoming Events -----------------------------------------------
              FutureBuilder(
                  future: currentUserController.getUserRegisteredEvents(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        // Registered Events Exists ----------------------------
                        return SizedBox(
                          width: width,
                          height: 320,
                          child: Scrollbar(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return HorizontalScrollEventsWidget(
                                        event: snapshot.data![index]);
                                  }),
                            ),
                          ),
                        );
                      }

                      // No Registered Events ----------------------------------
                      return const NoRegistredEventWidget();
                    }

                    // Loading Events ------------------------------------------
                    return SizedBox(
                      width: width * 0.9,
                      height: 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  })),

              const SizedBox(height: 20),

              // Your Bookmarked Events Text ===================================
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                decoration: const BoxDecoration(color: primaryColor100),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Bookmarked Events ...",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: textColor500,
                          fontFamily: 'Raleway',
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                ),
              ),

              // Bookmarked Events ---------------------------------------------
              FutureBuilder(
                  future: currentUserController.getBookmarkedEvents(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        // Bookmarked Events Exist -----------------------------
                        return SizedBox(
                          width: width,
                          height: 320,
                          child: Scrollbar(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return HorizontalScrollEventsWidget(
                                        event: snapshot.data![index]);
                                  }),
                            ),
                          ),
                        );
                      }
                      // No BookmarkedEvents -----------------------------------
                      return const NoBookmarkedEventWidget();
                    }
                    // Loading Events ------------------------------------------
                    return SizedBox(
                      width: width * 0.9,
                      height: 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  })),

              const SizedBox(height: 20)
            ],
          ),
        ));
  }
}
