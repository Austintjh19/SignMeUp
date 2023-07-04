import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/CurrentUserController.dart';
import 'package:myapplication/src/features/dashboard/controllers/OtherUsersController.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/DetailsWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/ParticipantsWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/RegisterButton.dart';

import '../../../../constants/image_strings.dart';
import '../../../../models/EventModel.dart';
import '../../../../models/UserModel.dart';
import '../../controllers/GeneralEventController.dart';

class EventScreen extends StatefulWidget {
  final String eventID;
  const EventScreen({super.key, required this.eventID});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool onDetailsPage = true;

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(GeneralEventController());
    final otherUsersController = Get.put(OtherUsersController());
    final currentUserController = Get.put(CurrentUserController());
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined,
                color: Colors.black, size: 25)),
        centerTitle: true,
        title: const Text(
          "Review",
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: textColor600),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: eventController.getEventData(widget.eventID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  EventModel eventData = snapshot.data as EventModel;
                  return Column(
                    children: [
                      const SizedBox(height: 20),

                      // Activity Image
                      FutureBuilder(
                          future: eventController
                              .getEventImage(eventData.eventImage),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                String imageUrl = snapshot.data as String;
                                return imageUrl != ""
                                    ? Container(
                                        width: width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(imageUrl),
                                              fit: BoxFit.cover),
                                        ),
                                      )
                                    : Container(
                                        width: width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: ExactAssetImage(
                                                  defaultEventImage),
                                              fit: BoxFit.fill),
                                        ),
                                      );
                              }
                            }
                            return const CircularProgressIndicator();
                          }),

                      const SizedBox(height: 10),

                      // // Event Name, Event Location and Event Organizer
                      Container(
                        width: width,
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Event Name & Location
                                    Text(
                                      "${eventData.eventName.last} @ ${eventData.eventLocation.last}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          color: textColor600),
                                    ),

                                    const SizedBox(height: 5),

                                    // Event Organizer
                                    FutureBuilder(
                                        future:
                                            otherUsersController.getUserData(
                                                eventData.eventOrganizer),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              UserModel organizerDetails =
                                                  snapshot.data as UserModel;
                                              return Text(
                                                "Organizer: ${organizerDetails.name}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: textColor400),
                                              );
                                            }
                                          }
                                          return Text('');
                                        }),
                                  ],
                                ),

                                const Spacer(),

                                // Save Button
                                FutureBuilder(
                                    future: currentUserController
                                        .getIsEventBookmarked(eventData.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          bool isBookmared =
                                              snapshot.data as bool;
                                          return isBookmared
                                              ? GestureDetector(
                                                  onTap: () {
                                                    currentUserController
                                                        .removeFromBookmarkedEvents(
                                                            eventData.id);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.bookmark,
                                                    size: 25,
                                                    color: primaryColor300,
                                                  ))
                                              : GestureDetector(
                                                  onTap: () {
                                                    currentUserController
                                                        .addToBookmarkedEvents(
                                                            eventData.id);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.bookmark_outline,
                                                    size: 25,
                                                    color: textColor600,
                                                  ));
                                        }
                                      }
                                      return Container();
                                    }),
                              ],
                            ),

                            const SizedBox(height: 30),

                            // Details And Participants Button
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: primaryColor100,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: defaultBoxShadow),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Details
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          onDetailsPage = true;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: onDetailsPage
                                            ? BoxDecoration(
                                                color: primaryColor100,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                boxShadow: defaultBoxShadow)
                                            : const BoxDecoration(
                                                color: Colors.transparent),
                                        child: Text(
                                          "Details",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: onDetailsPage
                                                  ? textColor600
                                                  : textColor300),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Participants
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          onDetailsPage = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: !onDetailsPage
                                            ? BoxDecoration(
                                                color: primaryColor100,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                boxShadow: defaultBoxShadow)
                                            : const BoxDecoration(
                                                color: Colors.transparent),
                                        child: Text(
                                          "Participants",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: !onDetailsPage
                                                  ? textColor600
                                                  : textColor300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Body of Event Screen
                            onDetailsPage
                                ? DetailsWidget(event: eventData)
                                : ParticipantsWidget(event: eventData),

                            const SizedBox(height: 30),

                            // Register / Registered

                            FutureBuilder(
                                future: currentUserController
                                    .getIsEventRegistered(eventData.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      bool isRegistered = snapshot.data as bool;
                                      if (isRegistered) {
                                        return RegisterButton(
                                            buttonColor: primaryColor600,
                                            buttonText: 'Registered',
                                            function: () {
                                              currentUserController
                                                  .removeFromRegisteredEvents(
                                                      eventData.id);
                                              eventController.removeParticipant(
                                                  eventData.id);
                                              eventController
                                                  .updateNumParticipant(
                                                      eventData.id,
                                                      eventData.participants
                                                              .length -
                                                          1);
                                              eventController.updateIsFull(
                                                  eventData.id,
                                                  eventData
                                                          .participants.length -
                                                      1,
                                                  int.parse(eventData
                                                      .participantsLimit));
                                              setState(() {});
                                            });
                                      } else if (eventData.isFull) {
                                        return RegisterButton(
                                            buttonColor: primaryColor600,
                                            buttonText: "Event Full",
                                            function: () {
                                              Get.snackbar(
                                                  "Can't Perform Action",
                                                  'Event is full, you can bookmark event in case there are any available spots later on.',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors
                                                      .redAccent
                                                      .withOpacity(0.1),
                                                  colorText: Colors.red);
                                            });
                                      }
                                      return RegisterButton(
                                          buttonColor: primaryColor300,
                                          buttonText: "Register",
                                          function: () {
                                            currentUserController
                                                .addToRegisteredEvents(
                                                    eventData.id);
                                            eventController
                                                .addParticipant(eventData.id);
                                            eventController
                                                .updateNumParticipant(
                                                    eventData.id,
                                                    eventData.participants
                                                            .length +
                                                        1);
                                            eventController.updateIsFull(
                                                eventData.id,
                                                eventData.participants.length +
                                                    1,
                                                int.parse(eventData
                                                    .participantsLimit));
                                            setState(() {});
                                          });
                                    }
                                  }
                                  return Container();
                                }),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
