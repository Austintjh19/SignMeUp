import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/screens/event/widgets/OtherParticipantWidget.dart';

import '../../../../../models/EventModel.dart';

class ParticipantsWidget extends StatelessWidget {
  final EventModel event;
  const ParticipantsWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Participants Data
        Container(
          width: width,
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: primaryColor100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: defaultBoxShadow),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Expanded(
                child: Icon(
                  CupertinoIcons.person_2,
                  color: textColor600.withOpacity(0.8),
                  size: 50,
                ),
              ),

              const VerticalDivider(
                thickness: 2.0,
              ),

              // Participants Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${event.participants.length.toString()}/${event.participantsLimit}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          color: textColor600),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Participants',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: textColor400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Container(
          width: width,
          height: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: primaryColor100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: defaultBoxShadow),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: event.participants.length,
              itemBuilder: (context, index) {
                return OtherParticipantWidget(uid: event.participants[index]);
              }),
        )
      ],
    );
  }
}
