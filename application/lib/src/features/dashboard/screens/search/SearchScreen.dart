import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
          title: const Text('Search'),
        ),
        body: const Center(child: Text('Search Page')));
  }
}
