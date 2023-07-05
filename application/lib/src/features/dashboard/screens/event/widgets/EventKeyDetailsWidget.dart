import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../models/EventModel.dart';
import '../../../../../models/UserModel.dart';
import '../../../controllers/CurrentUserController.dart';
import '../../../controllers/OtherUsersController.dart';

class EventKeyDetailsWidget extends StatefulWidget {
  final EventModel eventData;
  const EventKeyDetailsWidget({super.key, required this.eventData});

  @override
  State<EventKeyDetailsWidget> createState() => _EventKeyDetailsWidgetState();
}

class _EventKeyDetailsWidgetState extends State<EventKeyDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final otherUsersController = Get.put(OtherUsersController());
    final currentUserController = Get.put(CurrentUserController());
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Event Name & Location --------------------------------------------
            Text(
              "${widget.eventData.eventName.last} @ ${widget.eventData.eventLocation.last}",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: textColor600),
            ),

            const SizedBox(height: 5),

            // Event Organizer -------------------------------------------------
            FutureBuilder(
                future: otherUsersController
                    .getUserData(widget.eventData.eventOrganizer),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel organizerDetails = snapshot.data as UserModel;
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
                  return const Text('');
                }),
          ],
        ),

        const Spacer(),

        // Save Button ---------------------------------------------------------
        FutureBuilder(
            future:
                currentUserController.getIsEventBookmarked(widget.eventData.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  bool isBookmared = snapshot.data as bool;
                  return isBookmared
                      ? GestureDetector(
                          onTap: () {
                            currentUserController.removeFromBookmarkedEvents(
                                widget.eventData.id);
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
                                .addToBookmarkedEvents(widget.eventData.id);
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
    );
  }
}
