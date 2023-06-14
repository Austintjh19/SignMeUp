import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../Dashboard.dart';

class ExploreAndCreateWidget extends StatelessWidget {
  const ExploreAndCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Explore
        GestureDetector(
          onTap: () {
            Get.offAll(Dashboard(
              initialPageIndex: 1,
            ));
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 225,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container2Color,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Positioned(
                  left: 10,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore Now",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor100),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "See what's new.",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: textColor100),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 20,
                    child: Container(
                      height: 125,
                      width: width * 0.3,
                      child: Image.asset(exploreNow),
                    ))
              ],
            ),
          ),
        ),

        const Spacer(),

        // Create
        GestureDetector(
          onTap: () {
            Get.offAll(Dashboard(
              initialPageIndex: 3,
            ));
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 225,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container3Color,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const Positioned(
                  left: 10,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Event",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor100),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Meet new people.",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: textColor100),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 25,
                    child: Container(
                      height: 125,
                      width: width * 0.3,
                      child: Image.asset(createEvent),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
