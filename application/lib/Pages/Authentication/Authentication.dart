import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/features/home/HomePage.dart';
import 'package:myapplication/Pages/SignIn/SignInPage.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Logged In
          if (snapshot.hasData) {
            return const HomePage();
          }

          // Not Loffet in
          else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
