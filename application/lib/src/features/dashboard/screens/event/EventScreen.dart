import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';

import '../../../../constants/image_strings.dart';
import '../../../../models/EventModel.dart';
import '../../controllers/GeneralEventController.dart';

class EventScreen extends StatelessWidget {
  final EventModel event;
  const EventScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(GeneralEventController());
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
      body: Column(
        children: [
          // Activity Image
          FutureBuilder(
              future: eventController.getEventImage(event.eventImage),
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
        ],
      ),
    );
  }
}
