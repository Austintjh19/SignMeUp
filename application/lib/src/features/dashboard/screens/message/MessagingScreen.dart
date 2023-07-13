import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';

import 'package:myapplication/src/cubits/rooms/rooms_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/features/dashboard/screens/chat_page.dart';
//import 'package:myapplication/src/features/dashboard/screens/register_page.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:timeago/timeago.dart';

/// Displays the list of chat threads
class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  static Widget route() {
    return BlocProvider<RoomCubit>(
      create: (context) => RoomCubit()..initializeRooms(context),
      child: const MessagingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
      ),
      body: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          if (state is RoomsLoading) {
            return preloader;
          } else if (state is RoomsLoaded) {
            final newUsers = state.newUsers;
            final rooms = state.rooms;
            return Builder(
              builder: (context) {
                //final userProfile_state = context.watch<UserProfilesCubit>().state;
                final groupProfile_state = context.watch<GroupProfilesCubit>().state;
                if ( groupProfile_state is GroupProfilesLoaded ) {
                  //final userProfiles = userProfile_state.profiles;
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
                  child: Padding(
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
                  ),
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