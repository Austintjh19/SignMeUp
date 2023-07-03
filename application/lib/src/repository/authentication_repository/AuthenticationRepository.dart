import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/repository/authentication_repository/exceptions/SignUpExceptions.dart';

import '../../common_widgets/CircularProgressWidget.dart';
import '../../models/UserModel.dart';
import '../event_repository/EventRepository.dart';
import '../user_repository/UserRepository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  final _eventRepository = Get.put(EventRepository());

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  late final Rx<User?> firebaseUser;
  static String verificationID = '';
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
        : Get.offAll(Dashboard(
            initialPageIndex: -1,
          ));
  }

  Future<String> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        verificationID = verificationID;
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        verificationID = verificationID;
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
    return verificationID;
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

  Future<bool> verifyOTP(String otp, String phoneVerificationID) async {
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
                verificationId: verificationID, smsCode: otp));
        return credentials.user != null ? true : false;
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        throw e;
      }
    }
    return false;
  }

  Future<UserCredential> createUserViaEmailAndPassword(
      String email, String password) async {
    CircularProgressWidget.getCircularProgressIndicator();

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      CircularProgressWidget.popCircularProgressIndicator();
      firebaseUser.value != null
          ? Get.offAll(() => Dashboard(
                initialPageIndex: -1,
              ))
          : Get.offAll(() => const SignInScreen());
      return credential;
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
      CircularProgressWidget.popCircularProgressIndicator();
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

  Future<void> signInWithGoogle() async {
    CircularProgressWidget.getCircularProgressIndicator();
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        final user = UserModel([], [],
            uid: userCredential.user!.uid,
            username: gUser.email.substring(0, gUser.email.indexOf('@')),
            name: gUser.email.substring(0, gUser.email.indexOf('@')),
            email: gUser.email,
            password: '',
            profileImage: '',
            description: '');
        await _userRepository.storeUserDetails(user, userCredential);
      }
    } on FirebaseAuthException catch (e) {
      CircularProgressWidget.popCircularProgressIndicator();
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      rethrow;
    }
  }

  Future<void> signInWithFacebook() async {
    CircularProgressWidget.getCircularProgressIndicator();
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential fAuth =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(fAuth);
      if (userCredential.additionalUserInfo!.isNewUser) {
        final user = UserModel([], [],
            uid: userCredential.user!.uid,
            username: '',
            name: '',
            email: '',
            password: '',
            profileImage: '',
            description: '');
        await _userRepository.storeUserDetails(user, userCredential);
      }
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

  Future<void> deleteUserAccount(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await _auth.currentUser
          ?.reauthenticateWithCredential(credential)
          .then((value) async {
        final uid = firebaseUser.value?.uid;
        UserModel userData = await _userRepository.getUserData(uid!);
        if (userData.registeredEvents != null) {
          for (var index = 0;
              index < userData.registeredEvents!.length;
              index++) {
            _eventRepository.removeParticipant(
                uid, userData.registeredEvents?[index]);
          }
        }
        value.user?.delete().then((res) {
          Get.snackbar("Success",
              '"Your User Account and all its related details have been deleted from our system.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
        });
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }
}
