import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/SignInAction.dart';

// Figure out Future and Async Dart
class CreateNewUserAction {
  final String email;
  final String password;
  final String name;
  final String username;
  final String confirmPassword;
  final BuildContext context;

  CreateNewUserAction(this.email, this.password, this.confirmPassword,
      this.context, this.name, this.username);

  void registerEmailAndPassword() async {
    if (passwordConfirmed()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }
  }

  bool passwordConfirmed() {
    return password == confirmPassword;
  }

  void registerDetails() async {
    await FirebaseFirestore.instance.collection('UsersSignUpInfo').add({
      'Name': name,
      'Username': username,
      'Email': email,
    });
  }

  void createNewUser() async {
    registerEmailAndPassword();
    registerDetails();
  }

  void autoSignIn() {
    SignInAction(email, password, context).signUserIn();
  }
}
