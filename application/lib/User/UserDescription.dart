import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDescription {
  final String description;

  UserDescription(this.description);

  void setUserDescription() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      FirebaseFirestore.instance
          .collection('UsersSignUpInfo')
          .doc(user?.uid)
          .update({'Description': description});
    });
  }
}
