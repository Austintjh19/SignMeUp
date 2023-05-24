import 'package:flutter/material.dart';

class Verification {
  final BuildContext _context;

  Verification(this._context);

  bool equivalentPassword(String password1, String password2) {
    if (password1 == password2) {
      return true;
    }
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
    return false;
  }

  bool appropriatePasswordLength(String password) {
    if (password.length >= 8) {
      return true;
    }
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
    return false;
  }
}
