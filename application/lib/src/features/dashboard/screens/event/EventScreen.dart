import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/OtherUsersController.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/DetailsWidget.dart';

import '../../../../constants/image_strings.dart';
import '../../../../models/EventModel.dart';
import '../../../../models/UserModel.dart';
import '../../controllers/GeneralEventController.dart';

class EventScreen extends StatefulWidget {
  final EventModel event;
  const EventScreen({super.key, required this.event});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool onDetailsPage = true;

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(GeneralEventController());
    final otherUsersController = Get.put(OtherUsersController());
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Activity Image
            FutureBuilder(
                future: eventController.getEventImage(widget.event.eventImage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      String imageUrl = snapshot.data as String;
                      return imageUrl != ""
                          ? Container(
                              width: width,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: width,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: ExactAssetImage(defaultEventImage),
                                    fit: BoxFit.fill),
                              ),
                            );
                    }
                  }
                  return Container(
                    width: width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: ExactAssetImage(defaultEventImage),
                          fit: BoxFit.fill),
                    ),
                  );
                }),

            const SizedBox(height: 10),

            // Event Name, Event Location and Event Organizer
            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Event Name & Location
                  Text(
                    "${widget.event.eventName.last} @ ${widget.event.eventLocation.last}",
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
                      future: otherUsersController
                          .getUserData(widget.event.participants.first),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel organizerDetails =
                                snapshot.data as UserModel;
                            return Text(
                              "Organizer: ${organizerDetails.name}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: textColor400),
                            );
                          }
                        }
                        return const Text(
                          "Organizer: Unknown",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: textColor400),
                        );
                      }),

                  const SizedBox(height: 30),

                  // Details And Participants Button
                  Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: primaryColor100,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: defaultBoxShadow),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      borderRadius: BorderRadius.circular(100),
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
                                      borderRadius: BorderRadius.circular(100),
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
                      ? DetailsWidget(event: widget.event)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
