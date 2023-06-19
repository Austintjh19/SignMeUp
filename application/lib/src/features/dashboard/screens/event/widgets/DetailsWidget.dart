import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';

import '../../../../../models/EventModel.dart';

class DetailsWidget extends StatelessWidget {
  final EventModel event;
  const DetailsWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Date Time & Location
        Container(
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: primaryColor100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: defaultBoxShadow),
          child: Column(
            children: [
              // Date and Time of Event
              Row(
                children: [
                  Icon(
                    CupertinoIcons.calendar_today,
                    color: textColor600.withOpacity(0.8),
                    size: 30,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    '${event.eventDate} @ ${event.eventTime}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: textColor600),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Location
              Row(
                children: [
                  Icon(
                    CupertinoIcons.placemark,
                    color: textColor600.withOpacity(0.8),
                    size: 30,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    '${event.eventLocation.last}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: textColor600),
                  ),
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Description

        const SizedBox(height: 20),
        Text(
          event.eventDescription,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.normal,
              fontSize: 12,
              height: 1.5,
              color: textColor600),
        ),
      ],
    );
  }
}
