part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  ChatLoaded(this.messages,this.room_id);
  final List<Message> messages;
  final String room_id;
}
/*class ChatMemberLoaded extends ChatState {
  ChatMemberLoaded(this.members);
  final List<String> members;
}*/
class ChatEmpty extends ChatState {}

class ChatError extends ChatState {
  ChatError(this.message);
  final String message;
}
