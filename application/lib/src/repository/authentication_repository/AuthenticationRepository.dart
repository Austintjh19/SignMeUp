import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/features/dashboard/screens/home/HomeScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/exceptions/SignUpExceptions.dart';

import '../../common_widgets/CircularProgressWidget.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationID = ''.obs;
  bool verifyViaEmailOTP = true;

  EmailOTP myEmailAuth = EmailOTP();

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(const SignInScreen())
        : Get.offAll(const Dashboard());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationID.value = verificationID as String;
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        verificationID.value = verificationID as String;
      }),
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "Invalid phone number provided.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
        } else {
          Get.snackbar("Error", e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
        }
      },
    );
  }

  Future<void> emailAuthentication(String email) async {
    myEmailAuth.setConfig(
        appEmail: "SignMeUp@gmail.com",
        appName: "Email OTP",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    bool res = await myEmailAuth.sendOTP();
    if (res) {
      print("sent");
    } else {
      print("not sent");
    }
  }

  Future<bool> verifyOTP(String otp) async {
    if (verifyViaEmailOTP == true) {
      try {
        bool res = await myEmailAuth.verifyOTP(otp: otp);
        return res;
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      }
    } else {
      try {
        var credentials = await _auth.signInWithCredential(
            PhoneAuthProvider.credential(
                verificationId: this.verificationID.value, smsCode: otp));
        return credentials.user != null ? true : false;
      } on FirebaseAuthException catch (e) {
        final ex = SignUpExceptions.code(e.code);
        print(e.toString());
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        throw ex;
      }
    }
    return false;
  }

  Future<void> createUserViaEmailAndPassword(
      String email, String password) async {
    CircularProgressWidget.getCircularProgressIndicator();

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      CircularProgressWidget.popCircularProgressIndicator();
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const SignInScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpExceptions.code(e.code);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      throw ex;
    } catch (_) {
      CircularProgressWidget.popCircularProgressIndicator();
      const ex = SignUpExceptions();
      throw ex;
    }
  }

  Future<void> signInUserViaEmailAndPassword(
      String email, String password) async {
    CircularProgressWidget.getCircularProgressIndicator();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      CircularProgressWidget.popCircularProgressIndicator();
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<void> resetPasswordViaEmail(String email) async {
    CircularProgressWidget.getCircularProgressIndicator();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar("Success",
          "Password reset link sent. Check registered email for notification. If not present, check spam folder.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green);
    } on FirebaseAuthException catch (e) {
      CircularProgressWidget.popCircularProgressIndicator();
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    CircularProgressWidget.getCircularProgressIndicator();

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      CircularProgressWidget.popCircularProgressIndicator();
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}
