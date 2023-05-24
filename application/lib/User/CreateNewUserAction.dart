import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:myapplication/Pages/Home/HomePage.dart';
import 'package:myapplication/User/SignInAction.dart';

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

  bool registerEmailAndPassword() {
    if (passwordConfirmed()) {
      if (password.length >= 8) {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return true;
      } else {
        invalidPasswordLenNotification();
      }
    } else {
      invalidPasswordSimilarityNoticication();
    }
    return false;
  }

  bool passwordConfirmed() {
    return password == confirmPassword;
  }

  bool createNewUser() {
    final json = {
      'Name': name,
      'Username': username,
      'Email': email,
      'Date Of Birth': '',
      'Description': '',
      'Interest': '',
    };

    if (registerEmailAndPassword()) {
      FirebaseFirestore.instance.collection('UsersSignUpInfo').add(json);
      return true;
    }

    return false;
  }

  void invalidPasswordSimilarityNoticication() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Password do not match please reenter.',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Color.fromRGBO(42, 42, 42, 1)),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  void invalidPasswordLenNotification() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Invalid Password Length, must be more than 8 letters.',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Color.fromRGBO(42, 42, 42, 1)),
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
