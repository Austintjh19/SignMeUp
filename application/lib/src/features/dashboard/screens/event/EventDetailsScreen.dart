import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/EventDetailsOrParticipantsWidget.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/EventImage.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/EventKeyDetailsWidget.dart';

import '../../../../models/EventModel.dart';
import '../../controllers/GeneralEventController.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventID;
  const EventDetailsScreen({super.key, required this.eventID});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool onDetailsPage = true;

  @override
  Widget build(BuildContext context) {
    final generalEventController = Get.put(GeneralEventController());
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
            future: generalEventController.getEventData(widget.eventID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  EventModel eventData = snapshot.data as EventModel;
                  return Column(
                    children: [
                      const SizedBox(height: 20),

                      // Event Image -------------------------------------------
                      EventImage(eventData: eventData),

                      const SizedBox(height: 10),

                      // Event Details =========================================
                      Container(
                        width: width,
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Name, Location, Organizer & Save Button ---
                            EventKeyDetailsWidget(eventData: eventData),

                            const SizedBox(height: 30),

                            // Details Or Participants Page ------------------
                            EventDetailsOrParticipantsWidget(
                                eventData: eventData),

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
