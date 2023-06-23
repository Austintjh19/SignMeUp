import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/SettingsScreen.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../Dashboard.dart';

class ExploreAndCreateWidget extends StatelessWidget {
  const ExploreAndCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 265,
      color: primaryColor100,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 20),

          // Explore
          GestureDetector(
            onTap: () {
              Get.offAll(Dashboard(
                initialPageIndex: 1,
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 210,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container2Color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(219, 101, 140, 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                ),
                const Positioned(
                  left: 10,
                  bottom: 20,
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

          const SizedBox(width: 20),

          // Create
          GestureDetector(
            onTap: () {
              Get.offAll(Dashboard(
                initialPageIndex: 3,
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 210,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container3Color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(201, 115, 255, 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                ),
                const Positioned(
                  left: 10,
                  bottom: 20,
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

          const SizedBox(width: 20),

          // Personalize
          GestureDetector(
            onTap: () {
              Get.to(const SettingsScreen());
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 210,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container4Color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(145, 234, 228, 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                ),
                const Positioned(
                  left: 10,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personalize",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor100),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Introduce Yourself.",
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
                      child: Image.asset(personalize),
                    ))
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Connect
          GestureDetector(
            onTap: () {
              Get.offAll(Dashboard(
                initialPageIndex: 2,
              ));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 210,
                  width: width * 0.42,
                  decoration: BoxDecoration(
                      gradient: container5Color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(252, 182, 159, 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ]),
                ),
                const Positioned(
                  left: 10,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Connect",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor100),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Message your friends.",
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
                      child: Image.asset(connect),
                    ))
              ],
            ),
          ),

          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
