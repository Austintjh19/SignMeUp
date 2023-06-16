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
          physics: const ScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            // Explore and Create Button
            child: Column(
              children: [
                // Explore and Create Widget
                const ExploreAndCreateWidget(),

                const SizedBox(height: 30),
                // Your Upcoming Events
                const Align(
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
                const Divider(),

                const SizedBox(height: 20),

                FutureBuilder(
                    future: displayEventsController.getUserRegisteredEvents(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (c, index) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: width * 0.9,
                                        height: 275,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Activity Image
                                              FutureBuilder(
                                                  future:
                                                      displayEventsController
                                                          .getEventImage(
                                                              snapshot
                                                                  .data![index]
                                                                  .eventImage),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      if (snapshot.hasData) {
                                                        String imageUrl =
                                                            snapshot.data
                                                                as String;
                                                        return imageUrl != ""
                                                            ? Container(
                                                                width:
                                                                    width * 0.9,
                                                                height: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            imageUrl),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              )
                                                            : Container(
                                                                width:
                                                                    width * 0.9,
                                                                height: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: const DecorationImage(
                                                                        image: ExactAssetImage(
                                                                            defaultEventImage),
                                                                        fit: BoxFit
                                                                            .fill)),
                                                              );
                                                      }
                                                    }
                                                    return const CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage:
                                                          ExactAssetImage(
                                                              defaultProfileImage),
                                                    );
                                                  }),

                                              const SizedBox(height: 10),

                                              // Event Name And Location
                                              Text(
                                                "${snapshot.data![index].eventName} @ ${snapshot.data![index].eventLocation}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: textColor500),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  //
                                                  const Icon(
                                                      Icons.person_2_outlined,
                                                      size: 16),
                                                  const SizedBox(width: 5),

                                                  Text(
                                                    "Participants: ${snapshot.data![index].participants.length}/${snapshot.data![index].participantsLimit}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: textColor500),
                                                  ),

                                                  const Spacer(),
                                                  Text(
                                                    "${snapshot.data![index].eventDate} @ ${snapshot.data![index].eventTime}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: textColor500),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                    ),
                                    const SizedBox(height: 30)
                                  ],
                                );
                              });
                        }
                        // No Signed Up Events
                        return const NoUpcomingEventsWidget();
                      }
                      // Loading Events
                      return const CircularProgressIndicator();
                    }))
              ],
            ),
          ),
        ));
  }
}
