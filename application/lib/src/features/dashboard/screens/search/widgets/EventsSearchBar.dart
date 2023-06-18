import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/screens/search/SearchScreen.dart';

import '../../../../../constants/colors.dart';
import '../../../controllers/SearchEventController.dart';

class EventsSearchBar extends StatelessWidget {
  const EventsSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchEventController = Get.put(SearchEventController());

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        controller: searchEventController.stringQuery,
        onChanged: (query) {
          searchEventController.searchEvents();
        },
        maxLines: 1,
        style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            fontSize: 15,
            color: textColor500),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.transparent)),
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
    );
  }
}