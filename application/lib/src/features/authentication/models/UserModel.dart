class UserModel {
  final String? id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String profileImage;
  final String description;

  const UserModel(
      {this.id,
      required this.username,
      required this.name,
      required this.email,
      required this.password,
      required this.profileImage,
      required this.description});

  toJson() {
    return {
      'Name': name,
      'Username': username,
      'Email': email,
      'Password': password,
      'Profile Image': profileImage,
      'Description': description
    };
  }
}
