import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../controllers/SettingsController.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());

    return ListTile(
      onTap: () async {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: primaryColor100.withOpacity(0.9),
                title: const Text(
                  'Delete Account ?',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: textColor600),
                ),
                content: Container(
                    height: 400,
                    padding: const EdgeInsets.all(0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Warning Icon
                          const Icon(Icons.dangerous_outlined,
                              color: Colors.redAccent, size: 150),

                          const SizedBox(height: 10),

                          // Delete Warning
                          const Text(
                            'Are you sure you want to delete your account ? All user information will be removed from our system. Enter your password and click Proceed to continue.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                color: textColor600),
                          ),

                          const SizedBox(height: 30),

                          TextFormField(
                            controller: settingsController.password,
                            obscureText: true,
                            style: const TextStyle(
                                color: textColor600,
                                fontFamily: 'Raleway',
                                fontSize: 12),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                hintText: 'Enter Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: primaryColor400)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: primaryColor400)),
                                prefixIcon:
                                    const Icon(Icons.password_outlined)),
                          ),

                          const SizedBox(height: 40),

                          // Proceed with Account Deletion Button
                          ElevatedButton(
                            onPressed: () {
                              settingsController.deleteUserAccount();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 0),
                              minimumSize: const Size.fromHeight(30),
                              shadowColor: primaryColor700,
                              elevation: 20,
                              backgroundColor: primaryColor600,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            child: const Text(
                              'Proceed',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 14,
                                  color: textColor100),
                            ),
                          )
                        ])),
              );
            });
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(119, 143, 253, 1).withOpacity(0.1)),
        child: const Icon(
          Icons.person_off_outlined,
          color: Color.fromRGBO(119, 143, 253, 1),
        ),
      ),
      title: const Text(
        'Delete Account',
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: heading1Color),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.1)),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18,
          color: Color.fromARGB(255, 124, 124, 124),
        ),
      ),
    );
  }
}
