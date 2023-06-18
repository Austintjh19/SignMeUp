import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/GeneralEventController.dart';
import 'package:myapplication/src/common_widgets/VerticalScrollEventsWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final eventController = Get.put(GeneralEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // Events Search Bar
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    controller: eventController.stringQuery,
                    onChanged: (query) {
                      eventController.searchEvents();
                      setState(() {});
                    },
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: textColor600),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        fillColor: primaryColor100,
                        filled: true,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Icon(
                            Icons.search_outlined,
                            color: primaryColor600,
                            size: 20,
                          ),
                        ),
                        hintText: 'Search ... ',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.menu_outlined,
                              color: primaryColor600,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        focusColor: primaryColor600),
                  ),
                ),

                const SizedBox(height: 20),

                // All Events
                FutureBuilder(
                    future: eventController.searchEvents(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (c, index) {
                                return VerticalScrollEventsWidget(
                                    eventImage:
                                        snapshot.data![index].eventImage,
                                    eventName: snapshot.data![index].eventName,
                                    eventLoncation:
                                        snapshot.data![index].eventLocation,
                                    eventDate: snapshot.data![index].eventDate,
                                    eventTime: snapshot.data![index].eventTime,
                                    numParticipant: snapshot
                                        .data![index].participants.length
                                        .toString(),
                                    participantsLimits: snapshot
                                        .data![index].participantsLimit);
                              });
                        }
                        // No Signed Up Events
                        return Container();
                      }
                      // Loading Events
                      return const CircularProgressIndicator();
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
