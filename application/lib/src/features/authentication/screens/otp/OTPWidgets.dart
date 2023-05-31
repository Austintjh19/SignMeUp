import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/FWTextButton.dart';

class OTPWidgets extends StatefulWidget {
  const OTPWidgets({super.key});

  @override
  State<OTPWidgets> createState() => _OTPWidgets();
}

class _OTPWidgets extends State<OTPWidgets> {
  final TextEditingController _phoneNumController = TextEditingController();
  Country country = CountryParser.parseCountryCode('SG');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Phone Number Text Field
        TextField(
          style: const TextStyle(
            color: Color.fromRGBO(42, 42, 42, 1),
            fontFamily: 'Raleway',
            fontSize: 18,
          ),
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.left,
          controller: _phoneNumController,
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
                borderSide:
                    const BorderSide(color: Color.fromRGBO(162, 178, 252, 1))),
            prefixIcon: Container(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      countryListTheme:
                          CountryListThemeData(bottomSheetHeight: height * 0.5),
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
                      fontSize: 15,
                      color: Color.fromRGBO(42, 42, 42, 1),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        // Send Button
        FWTextButton(
            function: () {},
            description: 'Send',
            buttonColor: const Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
