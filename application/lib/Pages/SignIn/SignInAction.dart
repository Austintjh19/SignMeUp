import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInAction {
  final String identification;
  final String password;
  final BuildContext context;

  const SignInAction(
    this.identification,
    this.password,
    this.context,
  );

  signUserIn() async {
    // Display loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: identification,
        password: password,
      );

      // Remove loading circle
      Navigator.pop(context);
    } on FirebaseAuthException {
      // Remove loading circle
      Navigator.pop(context);

      invalidSignInNotification();
    }
  }

  void invalidSignInNotification() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Invalid Username or Password',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Color.fromRGBO(42, 42, 42, 1)),
            ),
          );
        });
  }
}
