import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/controllers/GeneralEventController.dart';
import 'package:myapplication/src/features/dashboard/screens/event/EventScreen.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../models/EventModel.dart';

class HorizontalScrollEventsWidget extends StatelessWidget {
  final EventModel event;
  const HorizontalScrollEventsWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final eventsController = Get.put(GeneralEventController());
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Get.to(EventScreen(eventID: event.id),
                transition: Transition.rightToLeft);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            width: width * 0.9,
            height: 275,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor100,
                boxShadow: defaultBoxShadow),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Activity Image
              FutureBuilder(
                  future: eventsController.getEventImage(event.eventImage),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        String imageUrl = snapshot.data as String;
                        return imageUrl != ""
                            ? Container(
                                width: width * 0.9,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                width: width * 0.9,
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
                      width: width * 0.9,
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

              // Event Name And Location
              Text(
                '${event.eventName.last} @ ${event.eventLocation.last}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: textColor600),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  // Participants
                  const Icon(Icons.person_2_outlined, size: 16),
                  const SizedBox(width: 5),

                  Text(
                    "Participants: ${event.participants.length.toString()}/${event.participantsLimit}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: textColor600),
                  ),

                  const Spacer(),
                  Text(
                    "${event.eventDate} @ ${event.eventTime}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: textColor600),
                  ),
                ],
              )
            ]),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
