import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/image_strings.dart';
import '../../../../../models/EventModel.dart';
import '../../../controllers/GeneralEventController.dart';

class EventImage extends StatelessWidget {
  final EventModel eventData;
  const EventImage({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final generalEventController = Get.put(GeneralEventController());
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: generalEventController.getEventImage(eventData.eventImage),
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
                            image: NetworkImage(imageUrl), fit: BoxFit.cover),
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
          return const CircularProgressIndicator();
        });
  }
}
