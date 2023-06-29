import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/GeneralEventController.dart';
import 'package:myapplication/src/common_widgets/VerticalScrollEventsWidget.dart';

import '../../Dashboard.dart';
import '../../controllers/FilterSearchController.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final eventController = Get.put(GeneralEventController());
  final filterSearchController = Get.put(FilterSearchController());

  bool _isDescending = true;
  String _filterBy = 'Event Date';

  @override
  void initState() {
    super.initState();
    _isDescending = true;
    _filterBy = 'Event Date';
  }

  Future<void> _refreshScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(Dashboard(initialPageIndex: 1));
    return Future.delayed(const Duration(seconds: 0));
  }

  _setSearchFilter(String filterBy, bool isDescending) {
    setState(() {
      _filterBy = filterBy;
      _isDescending = isDescending;
    });
    Navigator.pop(context);
  }

  _filterPopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: primaryColor100.withOpacity(0.9),
            title: const Text(
              'Search Filter',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: textColor600),
            ),
            content: Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Name
                    Row(
                      children: [
                        const Text(
                          'By Event Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: textColor400),
                        ),
                        const Spacer(),
                        DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                  value: false,
                                  child: Text('Ascending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                              DropdownMenuItem(
                                  value: true,
                                  child: Text('Descending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                            ],
                            onChanged: (val) {
                              _setSearchFilter('Event Name', val!);
                            })
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text(
                          'By Event Location',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: textColor400),
                        ),
                        const Spacer(),
                        DropdownButton(
                            value: _isDescending,
                            items: const [
                              DropdownMenuItem(
                                  value: false,
                                  child: Text('Ascending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                              DropdownMenuItem(
                                  value: true,
                                  child: Text('Descending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                            ],
                            onChanged: (val) {
                              _setSearchFilter('Event Location', val!);
                            })
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Event Date
                    Row(
                      children: [
                        const Text(
                          'By Event Date',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: textColor400),
                        ),
                        const Spacer(),
                        DropdownButton(
                            value: _isDescending,
                            items: const [
                              DropdownMenuItem(
                                  value: false,
                                  child: Text('Ascending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                              DropdownMenuItem(
                                  value: true,
                                  child: Text('Descending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                            ],
                            onChanged: (val) {
                              _setSearchFilter('Event Date', val!);
                            })
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Num Participants
                    Row(
                      children: [
                        const Text(
                          'Num Participants',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: textColor400),
                        ),
                        const Spacer(),
                        DropdownButton(
                            value: _isDescending,
                            items: const [
                              DropdownMenuItem(
                                  value: false,
                                  child: Text('Ascending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                              DropdownMenuItem(
                                  value: true,
                                  child: Text('Descending',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: textColor600))),
                            ],
                            onChanged: (val) {
                              _setSearchFilter('Participants', val!);
                            })
                      ],
                    )
                  ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      body: LiquidPullToRefresh(
        onRefresh: _refreshScreen,
        color: primaryColor100,
        backgroundColor: primaryColor300,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        height: 200,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    // Events Search Bar
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: defaultBoxShadow,
                          color: primaryColor100),
                      child: TextFormField(
                        controller: eventController.stringQuery,
                        onChanged: (query) {
                          eventController.searchEvents(
                              _filterBy, _isDescending);
                          setState(() {});
                        },
                        maxLines: 1,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: textColor600),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.transparent)),
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
                                onPressed: () {
                                  filterSearchController.getPopUp(context);
                                },
                              ),
                            ),
                            focusColor: primaryColor600),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Event List
                    FutureBuilder(
                        future: eventController.searchEvents(
                            _filterBy, _isDescending),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (c, index) {
                                    return VerticalScrollEventsWidget(
                                      event: snapshot.data![index],
                                    );
                                  });
                            }
                            // No Matching Events
                            return Container();
                          }
                          // Loading Events
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
