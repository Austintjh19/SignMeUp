// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'widgets/ForgotPasswordForm.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor100,
      appBar: AppBar(
        backgroundColor: primaryColor100,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined,
                color: primaryColor700, size: 25)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Body
            Container(
                width: width,
                padding: EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    // ForgotPassword Image
                    Image.asset(
                      forgotPasswordImage,
                      width: width * 0.75,
                    ),

                    const SizedBox(height: 20.0),

                    // Header
                    const AutoSizeText(
                      'Enter Registered Email to Reset Password.',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: textColor300),
                      maxLines: 1,
                    ),

                    const SizedBox(height: 25),

                    // ForgotPassword Form
                    ForgotPasswordForm(),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
