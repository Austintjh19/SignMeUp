import 'package:myapplication/src/models/message.dart';

import 'Searchable.dart';

class Room extends Searchable{
  Room({
    required this.id,
    required this.createdAt,
    required this.members,
    required this.roomName,
    required this.isPrivate,
    this.lastMessage,

  });

  /// ID of the room
  final String id;

  /// Date and time when the room was created
  final DateTime createdAt;

  /// a list of members in the room
  List<dynamic> members;

  /// Latest message submitted in the room
  final Message? lastMessage;

  ///name of the room
  String roomName;

  ///if the group is discoverable thru search
  bool isPrivate;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Creates a room object from room_participants table
  Room.fromRoom(Map<String,dynamic> map)
      : id = map['id'],
        createdAt = DateTime.parse(map['created_at']),
        members = map['members'] ,
        roomName = map['name'],
        isPrivate = map['is_private'],
        lastMessage = null;


  Room copyWith({
    String? id,
    DateTime? createdAt,
    List<dynamic>? members,
    Message? lastMessage,
    String? roomName,
    bool? isPrivate
  }) {
    return Room(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      roomName: roomName ?? this.roomName,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}
