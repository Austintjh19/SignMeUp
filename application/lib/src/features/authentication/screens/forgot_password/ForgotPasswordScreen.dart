// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/features/authentication/controllers/ForgotPasswordController.dart';
import '../../../../common_widgets/FWTextButton.dart';
import 'widgets/ForgotPasswordForm.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Return Button
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25, vertical: 25),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(0),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
            ),
            Container(
                width: width,
                padding: EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const AutoSizeText(
                      'Enter Registered Email to Reset Password.',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Color.fromRGBO(157, 157, 157, 1)),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 25),
                    ForgotPasswordForm(formKey: _formKey),
                    const SizedBox(height: 25),
                    FWTextButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            ForgotPasswordController.instance
                                .resetPasswordviaEmail();
                          }
                        },
                        description: 'Send',
                        buttonColor: const Color.fromRGBO(128, 150, 255, 1),
                        textColor: Colors.white),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
