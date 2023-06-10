class UserModel {
  final String name;
  final String username;
  final String email;
  final String password;
  final String profileImage;
  final String description;
  final String uid;

  UserModel(
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
}
