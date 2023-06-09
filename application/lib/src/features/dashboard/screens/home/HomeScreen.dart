import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
      //   ],
      //   title: const Text('Welcome'),
      // ),
      body: const Center(child: Text('Home Page')),
    );
  }
}
