import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../Dashboard.dart';

class NoRegistredEventWidget extends StatelessWidget {
  const NoRegistredEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: defaultBoxShadow,
            image: const DecorationImage(
                image: AssetImage(noUpcomingEvents), fit: BoxFit.cover)),
        child: Container(
          width: width * 0.9,
          height: 275,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: container4Color,
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No Upcoming Events",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: textColor100),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              const Flexible(
                child: Text(
                  "You have not registered for any events. Head to the explore page to register for interested events",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: textColor100),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: primaryColor100),
                  onPressed: () {
                    Get.offAll(Dashboard(
                      initialPageIndex: 1,
                    ));
                  },
                  child: const Text(
                    "See What's New",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromRGBO(127, 127, 213, 0.8)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
