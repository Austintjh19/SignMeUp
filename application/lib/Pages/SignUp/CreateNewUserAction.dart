import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/SignInAction.dart';

import '../SignIn/SignInAction.dart';

class CreateNewUserAction {
  final String email;
  final String password;
  final String confirmPassword;
  final BuildContext context;

  CreateNewUserAction(
      this.email, this.password, this.confirmPassword, this.context);

  Future<void> registerEmailAndPassword() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }

    return Future(() => null);
  }

  bool passwordConfirmed() {
    return password == confirmPassword;
  }

  void createNewUser() {}

  void autoSignIn() {
    SignInAction(email, password, context).signUserIn();
  }
}
