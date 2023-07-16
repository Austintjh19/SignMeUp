class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.firebase_user_id
  });

  /// User ID of the profile
  final String id;

  /// Username of the profile
  final String username;

  /// Date and time when the profile was created
  final DateTime createdAt;

  ///firebase id
  final String firebase_user_id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'firebase_user_id': firebase_user_id
    };
  }

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']),
        firebase_user_id = map['firebase_user_id'];

  Profile copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? firebase_user_id
  }) {
    return Profile(
      id: id ?? this.id,
      username: name ?? username,
      createdAt: createdAt ?? this.createdAt,
      firebase_user_id: firebase_user_id ?? this.firebase_user_id
    );
  }
}
