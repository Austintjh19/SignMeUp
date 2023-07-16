import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/components/user_avatar.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';

import 'package:myapplication/src/cubits/rooms/rooms_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/features/dashboard/screens/chat_page.dart';
//import 'package:myapplication/src/features/dashboard/screens/register_page.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:timeago/timeago.dart';

import '../../controllers/OtherUsersController.dart';

/// Displays the list of chat threads
class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  static Widget route() {
    /*return BlocProvider<RoomCubit>(
      create: (context) => RoomCubit()..initializeRooms(context),
      child: const MessagingScreen(),
    );*/
    return const MessagingScreen();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Scaffold(
        body: BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomsLoading) {
              print('roomsloading state is encountered');
              return preloader;
            } else if (state is RoomsLoaded) {
              print('roomsloaded state is encountered');
              final newUsers = state.newUsers;
              final rooms = state.rooms;
              return Builder(
                builder: (context) {
                  final groupProfile_state = context.watch<GroupProfilesCubit>().state;
                  if ( groupProfile_state is GroupProfilesLoaded ) {
                    print('groupprofilesloaded is predicated to be true');
                    final groupProfiles = groupProfile_state.profiles;
                    return Column(
                      children: [
                        _SearchBar(),
                        _NewUsers(newUsers: newUsers),
                        Expanded(
                          child: ListView.builder(
                            itemCount: rooms.length,
                            itemBuilder: (context, index) {
                              final room = rooms[index];
                              final group_profile = groupProfiles[room.id];

                              return ListTile(
                                onTap: () => Navigator.of(context)
                                    .push(ChatPage.route(room.id)),
                                leading: CircleAvatar(
                                  child: group_profile == null
                                      ? preloader
                                      : Text(group_profile.roomName.substring(0, 2)),
                                ),
                                title: Text(group_profile == null
                                    ? 'Loading...'
                                    : group_profile.roomName),
                                subtitle: room.lastMessage != null
                                    ? Text(
                                        room.lastMessage!.content,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const Text('Room created'),
                                trailing: Text(format(
                                    room.lastMessage?.createdAt ?? room.createdAt,
                                    locale: 'en_short')),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return preloader;
                  }
                },
              );
            } else if (state is RoomsEmpty) {
              print('roomsempty state processed');
              final newUsers = state.newUsers;
              return Column(
                children: [
                  _SearchBar(),
                  _NewUsers(newUsers: newUsers),
                  const Expanded(
                    child: Center(
                        child: Text('Start a chat by tapping on available \n'
                            'users in your friend list'),
                    ),
                  ),
                ],
              );
            } else if (state is RoomsError) {
              return Center(child: Text(state.message));
            }
            throw UnimplementedError();
          },
        ),
      ),
    );
  }
}

_filter_groups(String input) {

}

class _NewUsers extends StatelessWidget {
  const _NewUsers({
    Key? key,
    required this.newUsers,
  }) : super(key: key);

  final List<Profile> newUsers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: newUsers
            .map<Widget>((user) => InkWell(
                  onTap: () async {
                    try {
                      final roomId = await BlocProvider.of<RoomCubit>(context)
                          .createRoom(user.id, user.username);
                      Navigator.of(context).push(ChatPage.route(roomId));
                    } catch (err) {
                      context.showErrorSnackBar(
                          message: 'Failed creating a new room');
                      print(err);
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      final Future<String> firebase_avatar_future = get_user_firebase_avatar(user.id);
                      return FutureBuilder(
                        future: firebase_avatar_future,
                        builder: (context,snapshot) {
                          if(snapshot.hasData) {
                            return Image.network(snapshot
                                .data as String);
                          }else {
                            return CircularProgressIndicator();
                          }
                        },
      );
                    }
                  )

          /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        children: [
                          CircleAvatar(
                            child: Text(user.username.substring(0, 2)),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ))
            .toList(),
      ),
    );
  }
}
class _SearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.search, size: 30),
      title: TextField(
        onChanged: (input) => _filter_groups(input),
        decoration: const InputDecoration(
          hintText: 'search chat groups',
          focusedBorder: UnderlineInputBorder(),
          border: InputBorder.none,
        ),
      ),
    );
  }

}
Future<String> get_user_firebase_avatar(String id) async {
  print('get_user_firebase_id called');
  final data = await supabase.from('profiles').select('firebase_user_id').match({'id': id}).single();
  //data.then(print('data fetched: ${data.toString()}'));
  //final firebase_user_id = data.then((value) => value['firebase_user_id']);
  //print('firebase_user_id is $firebase_user_id');
  final firebase_id = await data['firebase_user_id'];
  final user_controller = Get.put(OtherUsersController());
  return await user_controller.getUserProfileImage(firebase_id);
}