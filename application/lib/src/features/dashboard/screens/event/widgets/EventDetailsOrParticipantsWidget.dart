import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../cubits/rooms/rooms_cubit.dart';
import '../../../../../models/EventModel.dart';
import '../../../../../utils/constants.dart';
import '../../../controllers/CurrentUserController.dart';
import '../../../controllers/GeneralEventController.dart';
import 'EventDetailsWidget.dart';
import 'EventParticipantsWidget.dart';
import 'RegisterButton.dart';

class EventDetailsOrParticipantsWidget extends StatefulWidget {
  final EventModel eventData;
  const EventDetailsOrParticipantsWidget({super.key, required this.eventData});

  @override
  State<EventDetailsOrParticipantsWidget> createState() =>
      _EventDetailsOrParticipantsWidgetState();
}

class _EventDetailsOrParticipantsWidgetState
    extends State<EventDetailsOrParticipantsWidget> {
  bool onDetailsPage = true;
  final currentUserController = Get.put(CurrentUserController());
  final generalEventController = Get.put(GeneralEventController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: primaryColor100,
              borderRadius: BorderRadius.circular(100),
              boxShadow: defaultBoxShadow),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Details Button ------------------------------------------------
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
                        : const BoxDecoration(color: Colors.transparent),
                    child: Text(
                      "Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: onDetailsPage ? textColor600 : textColor300),
                    ),
                  ),
                ),
              ),

              // Participants Button -------------------------------------------
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
                        : const BoxDecoration(color: Colors.transparent),
                    child: Text(
                      "Participants",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: !onDetailsPage ? textColor600 : textColor300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Body of Event Screen ================================================
        FutureBuilder(
            future: generalEventController.getEventData(widget.eventData.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  EventModel eventData = snapshot.data as EventModel;
                  return onDetailsPage
                      ? EventDetailsWidget(event: eventData)
                      : EventParticipantsWidget(event: eventData);
                }
              }
              return Container();
            }),

        const SizedBox(height: 30),

        // Register / Registered Button ========================================

        FutureBuilder(
            future:
                currentUserController.getIsEventRegistered(widget.eventData.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  bool isRegistered = snapshot.data as bool;
                  if (isRegistered) {
                    return RegisterButton(
                        buttonColor: primaryColor600,
                        buttonText: 'Registered',
                        function: (uuid) {
                          currentUserController
                              .removeFromRegisteredEvents(widget.eventData.id);
                          generalEventController
                              .removeParticipant(widget.eventData.id);
                          generalEventController.updateNumParticipant(
                              widget.eventData.id,
                              widget.eventData.participants.length - 1);
                          generalEventController.updateIsFull(
                              widget.eventData.id,
                              widget.eventData.participants.length - 1,
                              int.parse(widget.eventData.participantsLimit));
                          /// leave chat api call
                          setState(() {});
                        });
                  } else if (widget.eventData.isFull) {
                    return RegisterButton(
                        buttonColor: primaryColor600,
                        buttonText: "Event Full",
                        function: () {
                          Get.snackbar("Can't Perform Action",
                              'Event is full, you can bookmark event in case there are any available spots later on.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              colorText: Colors.red);
                        });
                  }
                  return RegisterButton(
                      buttonColor: primaryColor300,
                      buttonText: "Register",
                      function: (uuid) async {
                        currentUserController
                            .addToRegisteredEvents(widget.eventData.id);
                        generalEventController
                            .addParticipant(widget.eventData.id);
                        generalEventController.updateNumParticipant(
                            widget.eventData.id,
                            widget.eventData.participants.length + 1);
                        generalEventController.updateIsFull(
                            widget.eventData.id,
                            widget.eventData.participants.length + 1,
                            int.parse(widget.eventData.participantsLimit));
                        final room_id = await supabase.rpc(
                            'convert_to_uuid', params: {'input_value': widget.eventData.id});
                        print('firebase event id when trying to join the room: ${widget.eventData.id}');
                        print('room_id: $room_id');
                        BlocProvider.of<RoomCubit>(context).joinRoom(uuid, room_id);
                        setState(() {});
                      });
                }
              }
              return Container();
            }),

        const SizedBox(height: 30),
      ],
    );
  }
}
