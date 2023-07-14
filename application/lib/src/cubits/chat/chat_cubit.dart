import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapplication/src/models/message.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  StreamSubscription<List<Message>>? _messagesSubscription;
  List<Message> _messages = [];
  late StreamSubscription<List<dynamic>> _chatMembersSubscription;
  List<String> _chat_members = [];
  late final String _roomId;
  late final String _myUserId;
  void setMembersListener(String roomId, BuildContext context) {
    _chatMembersSubscription = supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .eq('id',roomId)
        .map<List<dynamic>>(
          //(data) => data.map<String>((row) => row['members'] as String).toList()
        (data) => data.first['members']
        ).listen((users) async {
          print(users);
          for ( String user in users ) {
            await BlocProvider.of<UserProfilesCubit>(context).getProfile(user);
            Map<String, dynamic> userinfo = await BlocProvider.of<
                UserProfilesCubit>(context).getUserInfo(user);
            print('user profiled loaded after entering chat '+user);
            String username = userinfo['username'];
            _chat_members.add(username);
            //print(_chat_members);
          }
          //emit(ChatMemberLoaded(_chat_members));
        }
        );
  }
  void setMessagesListener(String roomId, BuildContext context) {
    _roomId = roomId;
    _myUserId = supabase.auth.currentUser!.id;

    _messagesSubscription = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at')
        .map<List<Message>>(
          (data) => data
              .map<Message>(
                  (row) => Message.fromMap(map: row, myUserId: _myUserId))
              .toList(),
        ).listen((messages) {
          _messages = messages;
          if (_messages.isEmpty) {
            emit(ChatEmpty());
          } else {
            emit(ChatLoaded(_messages,_roomId));
          }
        });
  }

  Future<void> sendMessage(String text) async {
    /// Add message to present to the user right away
    final message = Message(
      id: 'new',
      roomId: _roomId,
      profileId: _myUserId,
      content: text,
      createdAt: DateTime.now(),
      isMine: true,
    );
    _messages.insert(0, message);
    emit(ChatLoaded(_messages, _roomId));

    try {
      await supabase.from('messages').insert(message.toMap());
    } catch (_) {
      emit(ChatError('Error submitting message.'));
      _messages.removeWhere((message) => message.id == 'new');
      emit(ChatLoaded(_messages,_roomId));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _chatMembersSubscription.cancel();
    return super.close();
  }
}
