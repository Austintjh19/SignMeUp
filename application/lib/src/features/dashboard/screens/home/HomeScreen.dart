import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/features/dashboard/controllers/CurrentUserController.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/NoBookmarkedEventWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/NoRegistredEventWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/ExploreAndCreateWidget.dart';
import 'package:myapplication/src/common_widgets/HorizontalScrollEventsWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              // Explore and Create Button

              // Explore and Create Widget
              const ExploreAndCreateWidget(),

              // Your Upcoming Events Text
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

              //  Your Upcoming Events
              FutureBuilder(
                  future: currentUserController.getUserRegisteredEvents(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return SizedBox(
                          width: width,
                          height: 320,
                          child: Scrollbar(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
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
                      // No Signed Up Events
                      return const NoRegistredEventWidget();
                    }
                    // Loading Events
                    return SizedBox(
                      width: width * 0.9,
                      height: 200,
                      child: const LinearProgressIndicator(),
                    );
                  })),

              const SizedBox(height: 20),

              // Your Bookmarked Events Text
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

              // Your Bookmarked Events
              FutureBuilder(
                  future: currentUserController.getBookmarkedEvents(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
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
                      // No Signed Up Events
                      return const NoBookmarkedEventWidget();
                    }
                    // Loading Events
                    return SizedBox(
                      width: width * 0.9,
                      height: 200,
                      child: const CircularProgressIndicator(),
                    );
                  })),

              const SizedBox(height: 20)
            ],
          ),
        ));
  }
}
