import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/dashboard/screens/create/CreateEventScreen.dart';

import '../../../../common_widgets/FullWidthTextButton.dart';

class CreateEventMainScreen extends StatelessWidget {
  const CreateEventMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(30),
        alignment: const Alignment(0, 0),
        child: Container(
          height: height * 0.7,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryColor500.withOpacity(0.05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Create Event Image
              Image.asset(
                createEventImage,
                width: width * 0.5,
              ),

              const SizedBox(height: 20.0),
              // Create Event Button
              FullWidthTextButton(
                  function: () {
                    Get.to(const CreateEventScreen());
                  },
                  description: 'Create Event',
                  buttonColor: primaryColor300,
                  textColor: textColor100),
            ],
          ),
        ),
      )),
    );
  }
}
