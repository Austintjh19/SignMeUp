import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPVerification {
  final BuildContext _context;

  OTPVerification(this._context);

  final _auth = FirebaseAuth.instance;
  String verificationId = '';

  Future<void> phoneVerification(String phoneNum) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNum,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: ((verificationId, resendToken) {
        this.verificationId = verificationId;
      }),
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          showDialog(
              context: _context,
              builder: (context) {
                return const AlertDialog(
                  title: Text(
                    'Invalid Phone Number Entered.',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Color.fromRGBO(42, 42, 42, 1)),
                    textAlign: TextAlign.center,
                  ),
                );
              });
        } else {
          showDialog(
              context: _context,
              builder: (context) {
                return const AlertDialog(
                  title: Text(
                    'An Error Occcured. Please Try Again.',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Color.fromRGBO(42, 42, 42, 1)),
                    textAlign: TextAlign.center,
                  ),
                );
              });
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp));
    return credentials.user != null ? true : false;
  }
}
