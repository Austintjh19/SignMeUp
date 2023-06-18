import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/controllers/GeneralEventController.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';

class VerticalScrollEventsWidget extends StatelessWidget {
  final String eventImage;
  final String eventName;
  final String eventLoncation;
  final String eventDate;
  final String eventTime;
  final String numParticipant;
  final String participantsLimits;

  const VerticalScrollEventsWidget(
      {super.key,
      required this.eventImage,
      required this.eventName,
      required this.eventLoncation,
      required this.eventDate,
      required this.eventTime,
      required this.numParticipant,
      required this.participantsLimits});

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(GeneralEventController());

    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 10),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: width * 0.9,
            height: 275,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor100),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Activity Image
              FutureBuilder(
                  future: eventController.getEventImage(eventImage),
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
                    return const CircleAvatar(
                      radius: 35,
                      backgroundImage: ExactAssetImage(defaultProfileImage),
                    );
                  }),

              const SizedBox(height: 10),

              // Event Name And Location
              Text(
                "$eventName @ $eventLoncation",
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
                  //
                  const Icon(Icons.person_2_outlined, size: 16),
                  const SizedBox(width: 5),

                  Text(
                    "Participants: $numParticipant/$participantsLimits",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: textColor600),
                  ),

                  const Spacer(),
                  Text(
                    "$eventDate @ $eventTime",
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
        const SizedBox(height: 10)
      ],
    );
  }
}
