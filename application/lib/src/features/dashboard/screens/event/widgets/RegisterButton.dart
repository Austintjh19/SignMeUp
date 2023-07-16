import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../constants/colors.dart';
import '../../../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../../../../utils/constants.dart';

class RegisterButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Function function;
  const RegisterButton(
      {super.key,
      required this.buttonColor,
      required this.buttonText,
      required this.function});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final firebase_auth = Get.put(AuthenticationRepository());
        String? firebase_uid = await firebase_auth.getCurrentUserUID();
        final uuid = await supabase.rpc(
            'convert_to_uuid', params: {'input_value': firebase_uid});
        function(uuid);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        minimumSize: const Size.fromHeight(30),
        shadowColor: primaryColor700,
        elevation: 20,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            fontFamily: 'Raleway', fontSize: 16, color: textColor100),
      ),
    );
  }
}
