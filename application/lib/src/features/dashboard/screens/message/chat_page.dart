import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/components/user_avatar.dart';
import 'package:myapplication/src/cubits/chat/chat_cubit.dart';
import 'package:myapplication/src/models/message.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:timeago/timeago.dart';

import '../../../../constants/colors.dart';

/// Page to chat with someone.
///
/// Displays chat bubbles as a ListView and TextField to enter new chat.
class ChatPage extends StatelessWidget {
  final String roomName;

  const ChatPage({required this.roomName, Key? key}) : super(key: key);

  static Route<void> route(String roomId, String roomName) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<ChatCubit>(
        create: (context) => ChatCubit()
          ..setMembersListener(roomId, context)
          ..setMessagesListener(roomId, context),
        child: ChatPage(roomName: roomName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined,
                color: Colors.black, size: 25)),
        centerTitle: true,
        title: Text(
          roomName,
          style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: textColor600),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            context.showErrorSnackBar(message: state.message);
          }
        },
        builder: (context, state) {
          if (state is ChatInitial) {
            return preloader;
          } else if (state is ChatLoaded) {
            /*List<String> members = state.members;
            for (String member in members){
              BlocProvider.of<UserProfilesCubit>(context).getProfile(member);
            }*/
            final messages = state.messages;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final Future<String> firebase_id_future =
                          get_user_firebase_id(message);
                      //print('firebase_id_future: $firebase_id_future');
                      return FutureBuilder(
                        future: firebase_id_future,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _ChatBubble(
                                message: message,
                                firebase_user_id: snapshot.data!);
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      );
                    },
                  ),
                ),
                const _MessageBar(),
              ],
            );
          } else if (state is ChatEmpty) {
            return const Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('Your epic conversation starts here :)'),
                  ),
                ),
                _MessageBar(),
              ],
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          throw UnimplementedError();
        },
      ),
    );
  }

  Future<String> get_user_firebase_id(Message message) async {
    print('get_user_firebase_id called');
    final data = await supabase
        .from('profiles')
        .select('firebase_user_id')
        .match({'id': message.profileId}).single();
    //data.then(print('data fetched: ${data.toString()}'));
    //final firebase_user_id = data.then((value) => value['firebase_user_id']);
    //print('firebase_user_id is $firebase_user_id');
    return await data['firebase_user_id'];
  }
}

/// Set of widget that contains TextField and Button to submit message
class _MessageBar extends StatefulWidget {
  const _MessageBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<_MessageBar> {
  late final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLines: null,
                autofocus: true,
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
            TextButton(
              onPressed: () => _submitMessage(),
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final text = _textController.text;
    if (text.isEmpty) {
      return;
    }
    BlocProvider.of<ChatCubit>(context).sendMessage(text);
    _textController.clear();
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    Key? key,
    required this.message,
    required this.firebase_user_id,
  }) : super(key: key);

  final Message message;
  final String firebase_user_id;
  @override
  Widget build(BuildContext context) {
    print(message.profileId);
    List<Widget> chatContents = [
      if (!message.isMine)
        UserAvatar(
          userId: message.profileId,
          firebase_user_id: firebase_user_id,
        ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? Colors.grey[300]
                : primaryColor200.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const SizedBox(width: 12),
      Text(format(message.createdAt, locale: 'en_short')),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
