import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/DisplayEventsController.dart';
import 'package:myapplication/src/features/dashboard/screens/home/widgets/ExploreAndCreateWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final displayEventsController = Get.put(DisplayEventsController());

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            // Explore and Create Button
            child: Column(
              children: [
                // Explore and Create Widget
                const ExploreAndCreateWidget(),

                const SizedBox(height: 30),
                // Your Upcoming Events
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Upcoming Events ...",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: textColor400,
                        fontFamily: 'Raleway',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),

                const SizedBox(height: 30),

                FutureBuilder(
                    future: displayEventsController.getUserRegisteredEvents(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (c, index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  child: Text(
                                      "Event Name: ${snapshot.data![index].eventName}"),
                                );
                              });
                        }
                      }
                      return Text("Sup");
                    }))
              ],
            ),
          ),
        ));
  }
}
