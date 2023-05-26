import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser {
  final String _email;
  final String _enteredPassword;
  final BuildContext _context;

  AppUser(this._email, this._enteredPassword, this._context);

  // AppUser(this._email, this._enteredPassword, this._context, [this._name = '', this._username = '',
  //     this._confirmPassword = '']);

  AppUser.signIn(this._email, this._enteredPassword, this._context);

  AppUser.signUp(context) : this('', '', context);

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

  bool createNewUser(Map<String, dynamic> map) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: map['Email'], password: map['Password']);
    map.remove('Password');
    FirebaseFirestore.instance.collection('UsersSignUpInfo').add(map);
    return true;
  }
}
