import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String username;
  final String email;
  final String password;
  final String profileImage;
  final String description;
  final String uid;
  final List? registeredEvents;
  final List? bookmarkedEvents;

  UserModel(this.registeredEvents, this.bookmarkedEvents,
      {required this.uid,
      required this.username,
      required this.name,
      required this.email,
      required this.password,
      required this.profileImage,
      required this.description});

  toJson() {
    return {
      "UID": uid,
      'Name': name,
      'Username': username,
      'Email': email,
      'Password': password,
      'Profile Image': profileImage,
      'Description': description
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final userData = document.data()!;
    return UserModel(
        userData["Registered Events"], userData["Bookmarked Events"],
        uid: userData["UID"],
        username: userData["Username"],
        name: userData["Name"],
        email: userData["Email"],
        password: userData["Password"],
        profileImage: userData["Profile Image"],
        description: userData["Description"]);
  }
}
