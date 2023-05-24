import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser {
  final String _email;
  final String _name;
  final String _username;
  final String _enteredPassword;
  final String _confirmPassword;
  final BuildContext _context;

  AppUser(this._email, this._name, this._username, this._enteredPassword,
      this._confirmPassword, this._context);

  // AppUser(this._email, this._enteredPassword, this._context, [this._name = '', this._username = '',
  //     this._confirmPassword = '']);

  AppUser.signUp(this._email, this._name, this._username, this._enteredPassword,
      this._confirmPassword, this._context);

  AppUser.signIn(email, enteredPassword, context)
      : this(email, '', '', enteredPassword, '', context);

  // SIGN IN
  //----------------------------------------------------------------------------

  signUserIn() async {
    showDialog(
        context: _context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _enteredPassword,
      );

      // Remove loading circle
      Navigator.pop(_context);
    } on FirebaseAuthException {
      // Remove loading circle
      Navigator.pop(_context);

      invalidSignInNotification();
    }
  }

  void invalidSignInNotification() {
    showDialog(
        context: _context,
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

  // SIGN UP
  //----------------------------------------------------------------------------

  bool createNewUser() {
    final json = {
      'Name': _name,
      'Username': _username,
      'Email': _email,
      'Date Of Birth': '',
      'Description': '',
      'Interest': '',
    };

    if (viaEmailAndPassword()) {
      FirebaseFirestore.instance.collection('UsersSignUpInfo').add(json);
      return true;
    }
    return false;
  }

  bool viaEmailAndPassword() {
    if (passwordConfirmed()) {
      if (_enteredPassword.length >= 8) {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email, password: _enteredPassword);
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
    return _enteredPassword == _confirmPassword;
  }

  void invalidPasswordSimilarityNoticication() {
    showDialog(
        context: _context,
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
        context: _context,
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
