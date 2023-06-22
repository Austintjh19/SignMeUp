import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/CurrentUserController.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/DefaultEventWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/ExploreAndCreateWidget.dart';
import 'package:myapplication/src/common_widgets/HorizontalScrollEventsWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserController = Get.put(CurrentUserController());
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Explore and Create Button
              Column(
                children: [
                  // Explore and Create Widget
                  const ExploreAndCreateWidget(),

                  // Your Upcoming Events

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
                ],
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
                      return const DefaultNoEventWidget();
                    }
                    // Loading Events
                    return const CircularProgressIndicator();
                  }))
            ],
          ),
        ));
  }
}
