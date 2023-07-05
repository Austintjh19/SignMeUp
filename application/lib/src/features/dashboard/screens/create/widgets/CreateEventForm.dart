import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/CreateEventController.dart';
import 'package:intl/intl.dart';
import 'package:myapplication/src/features/dashboard/screens/create/widgets/SelectEventImageWidget.dart';

import '../../../../../controllers/ValidationController.dart';
import '../../../controllers/CurrentUserController.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({super.key});

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  final currentUserController = Get.put(CurrentUserController());
  final createEventController = Get.put(CreateEventController());
  final validationController = Get.put(ValidationController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Select Event Image --------------------------------------------------
        const SelectEventImageWidget(),

        const SizedBox(height: 30),

        // Form ================================================================
        Container(
          width: width,
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor100,
              boxShadow: defaultBoxShadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name of Event -------------------------------------------------
              const Text(
                "* Event Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: createEventController.eventName,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Enter Event Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor400)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor400)),
                ),
              ),

              const SizedBox(height: 20),

              // Event Location ------------------------------------------------
              const Text(
                "* Event Location",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: createEventController.eventLocation,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Enter Event Location',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    prefixIcon: const Icon(Icons.location_on_outlined)),
              ),

              const SizedBox(height: 20),

              // Event Date ----------------------------------------------------
              const Text(
                "* Select Event Date",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                controller: createEventController.eventDate,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Select Event Date',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    prefixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                    )),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(DateTime.now().year + 1));

                  if (selectedDate != null) {
                    setState(() {
                      createEventController.eventDate.text =
                          DateFormat('EEEE, MMM d, yyyy').format(selectedDate);
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              // Event Time ----------------------------------------------------
              const Text(
                "* Select Event Time",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                controller: createEventController.eventTime,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Select Event Time',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    prefixIcon: const Icon(
                      Icons.access_time_outlined,
                      size: 20,
                    )),
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (selectedTime != null) {
                    setState(() {
                      createEventController.eventTime.text =
                          selectedTime.format(context).toString();
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              // Max Number of Participants ------------------------------------
              const Text(
                "* Max Number of Participants",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: createEventController.participantsLimit,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Enter Participants Limit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor400)),
                    prefixIcon: const Icon(Icons.people_outline_outlined)),
              ),

              const SizedBox(height: 20),

              // Event Description ---------------------------------------------
              const Text(
                "* Event Description",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: textColor600,
                    fontSize: 12),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 5,
                controller: createEventController.eventDescription,
                style: const TextStyle(
                    color: textColor600, fontFamily: 'Raleway', fontSize: 12),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Enter Event Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor400)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: primaryColor400)),
                ),
              ),

              const SizedBox(height: 30),

              // Create Event Button -------------------------------------------
              ElevatedButton(
                onPressed: () {
                  createEventController.createEvent();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  minimumSize: const Size.fromHeight(30),
                  shadowColor: primaryColor700,
                  elevation: 5,
                  backgroundColor: primaryColor300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(
                      fontFamily: 'Raleway', fontSize: 12, color: textColor100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
