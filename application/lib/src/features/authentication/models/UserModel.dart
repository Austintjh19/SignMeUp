class UserModel {
  final String? id;
  final String name;
  final String username;
  final String email;
  final String password;
  final String description;

  const UserModel(
      {this.id,
      required this.username,
      required this.name,
      required this.email,
      required this.password,
      required this.description});

  toJson() {
    return {
      'Name': name,
      'Username': username,
      'Email': email,
      'Password': password,
      'Description': description
    };
  }
}

                          // Map<String, dynamic> map = {
                          //   'Name': nameController.text.trim(),
                          //   'Username': usernameController.text.trim(),
                          //   'Email': emailController.text.trim(),
                          //   'Password': newPasswordController.text.trim(),
                          //   'Description': '',
                          // };
