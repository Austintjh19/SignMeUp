import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

final filterStateProvider = StateProvider<Map<String, String>>((ref) {
  return {
    'EventDateTime': 'Descending',
  };
});

final class FilterSearchController extends GetxController {
  static FilterSearchController get instance => Get.find();

  getPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer(builder: ((context, ref, child) {
            Map<String, String> filterCriteria = ref.watch(filterStateProvider);
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
                padding: const EdgeInsets.all(0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Name ----------------------------------------------
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
                              value: filterCriteria.containsKey('Event Name')
                                  ? filterCriteria['Event Name']
                                  : null,
                              hint: const Text('NA',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: textColor600)),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Descending',
                                    child: Text('Ascending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                                DropdownMenuItem(
                                    value: 'Ascending',
                                    child: Text('Descending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                              ],
                              onChanged: (val) {
                                ref.read(filterStateProvider.state).state = {
                                  'Event Name': val!
                                };
                              })
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Event Location ----------------------------------------------------
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
                              value:
                                  filterCriteria.containsKey('Event Location')
                                      ? filterCriteria['Event Location']
                                      : null,
                              hint: const Text('NA',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: textColor600)),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Descending',
                                    child: Text('Ascending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                                DropdownMenuItem(
                                    value: 'Ascending',
                                    child: Text('Descending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                              ],
                              onChanged: (val) {
                                ref.read(filterStateProvider.state).state = {
                                  'Event Location': val!
                                };
                              })
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Event Date --------------------------------------------------------
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
                              value: filterCriteria.containsKey('EventDateTime')
                                  ? filterCriteria['EventDateTime']
                                  : null,
                              hint: const Text('NA',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: textColor600)),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Descending',
                                    child: Text('Ascending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                                DropdownMenuItem(
                                    value: 'Ascending',
                                    child: Text('Descending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                              ],
                              onChanged: (val) {
                                ref.read(filterStateProvider.state).state = {
                                  'EventDateTime': val!
                                };
                              })
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Num Participants --------------------------------------------------
                      Row(
                        children: [
                          const Text(
                            'By Num Participants',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: textColor400),
                          ),
                          const Spacer(),
                          DropdownButton(
                              value: filterCriteria.containsKey('Participants')
                                  ? filterCriteria['Participants']
                                  : null,
                              hint: const Text('NA',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: textColor600)),
                              items: const [
                                DropdownMenuItem(
                                    value: 'Ascending',
                                    child: Text('Ascending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                                DropdownMenuItem(
                                    value: 'Descending',
                                    child: Text('Descending',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: textColor600))),
                              ],
                              onChanged: (val) {
                                ref.read(filterStateProvider.state).state = {
                                  'Participants': val!
                                };
                              })
                        ],
                      ),
                    ]),
              ),
            );
          }));
        });
  }
}
