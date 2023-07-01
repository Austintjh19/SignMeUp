import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/screens/create/widgets/CreateEventForm.dart';

import '../../../../constants/colors.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_outlined,
                  color: Colors.black, size: 25)),
          centerTitle: true,
          title: const Text(
            "New Event",
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: textColor600),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: CreateEventForm(),
          ),
        ));
  }
}
