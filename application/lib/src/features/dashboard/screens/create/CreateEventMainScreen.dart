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
          height: 600,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: container6Color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(createScreenImage)),

              const SizedBox(height: 20.0),

              const Flexible(
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: textColor100),
                ),
              ),

              const SizedBox(height: 20.0),

              // Create Event Button
              ElevatedButton(
                onPressed: () {
                  Get.to(const CreateEventScreen(),
                      transition: Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  minimumSize: const Size.fromHeight(20),
                  shadowColor: primaryColor700,
                  elevation: 10,
                  backgroundColor: const Color.fromRGBO(250, 172, 168, 0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(
                      fontFamily: 'Raleway', fontSize: 16, color: textColor100),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
