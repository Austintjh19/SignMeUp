import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapplication/src/features/dashboard/controllers/FilterSearchController.dart';

import '../../../../../constants/colors.dart';

class FilterPopUp extends ConsumerWidget {
  const FilterPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  hint: const Text('Not Applied',
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
                  value: filterCriteria.containsKey('Event Location')
                      ? filterCriteria['Event Location']
                      : null,
                  hint: const Text('Not Applied',
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
                  value: filterCriteria.containsKey('Event Date')
                      ? filterCriteria['Event Date']
                      : null,
                  hint: const Text('Not Applied',
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
                      'Event Date': val!
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
                  hint: const Text('Not Applied',
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
  }
}
