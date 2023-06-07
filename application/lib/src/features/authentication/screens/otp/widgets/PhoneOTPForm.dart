import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common_widgets/CircularProgress.dart';
import '../../../../../common_widgets/FWTextButton.dart';
import '../../../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../../controllers/OTPController.dart';
import '../../../controllers/ValidationController.dart';
import '../OTPScreen.dart';

class PhoneOTPForm extends StatefulWidget {
  const PhoneOTPForm({super.key});

  @override
  State<PhoneOTPForm> createState() => _OTPWidgets();
}

class _OTPWidgets extends State<PhoneOTPForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(OTPController());
  final validationController = Get.put(ValidationController());
  Country country = CountryParser.parseCountryCode('SG');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Phone Number Text Field
          TextFormField(
            style: const TextStyle(
              color: Color.fromRGBO(42, 42, 42, 1),
              fontFamily: 'Raleway',
              fontSize: 18,
            ),
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.left,
            controller: controller.phoneNumController,
            decoration: InputDecoration(
              labelText: 'Enter Phone Number',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: Container(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        countryListTheme: CountryListThemeData(
                            bottomSheetHeight: height * 0.5),
                        onSelect: (value) {
                          setState(() {
                            country = value;
                          });
                        });
                  },
                  child: Text(
                    "${country.flagEmoji} +${country.phoneCode}",
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Color.fromRGBO(42, 42, 42, 1),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            validator: validationController.validatePhoneNum,
          ),

          const SizedBox(height: 20.0),
          FWTextButton(
            description: 'Next',
            buttonColor: const Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white,
            function: () {
              if (_formKey.currentState!.validate()) {
                controller.phoneCode = "+${country.phoneCode}";
                AuthenticationRepository.instance.verifyViaEmailOTP = false;
                OTPController.instance.phoneNumAuthentication();
                CircularProgress.popCircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
