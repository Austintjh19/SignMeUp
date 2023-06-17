import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/dashboard/controllers/DisplayEventsController.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/ExploreAndCreateWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/NoUpcomingEventsWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/UpcomingEventsWidget.dart';

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
    final displayEventsController = Get.put(DisplayEventsController());
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                // Explore and Create Button
                child: const Column(
                  children: [
                    // Explore and Create Widget
                    ExploreAndCreateWidget(),

                    SizedBox(height: 30),
                    // Your Upcoming Events
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Upcoming Events ...",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: textColor400,
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              //  Your Upcoming Events
              FutureBuilder(
                  future: displayEventsController.getUserRegisteredEvents(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        return SizedBox(
                          width: width,
                          height: 300,
                          child: Scrollbar(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return UpcomingEventsWidget(
                                        eventImage:
                                            snapshot.data![index].eventImage,
                                        eventName:
                                            snapshot.data![index].eventName,
                                        eventLoncation:
                                            snapshot.data![index].eventLocation,
                                        eventDate:
                                            snapshot.data![index].eventDate,
                                        eventTime:
                                            snapshot.data![index].eventTime,
                                        numParticipant: snapshot
                                            .data![index].participants.length
                                            .toString(),
                                        participantsLimits: snapshot
                                            .data![index].participantsLimit);
                                  }),
                            ),
                          ),
                        );
                      }
                      // No Signed Up Events
                      return const NoUpcomingEventsWidget();
                    }
                    // Loading Events
                    return const CircularProgressIndicator();
                  }))
            ],
          ),
        ));
  }
}
