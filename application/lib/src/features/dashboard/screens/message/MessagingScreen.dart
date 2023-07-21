import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';

import 'package:myapplication/src/cubits/rooms/rooms_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/features/dashboard/screens/chat_page.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:timeago/timeago.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../models/UserModel.dart';
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
    return SingleChildScrollView(
      child: Container(
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
                    final groupProfile_state =
                        context.watch<GroupProfilesCubit>().state;
                    if (groupProfile_state is GroupProfilesLoaded) {
                      print('groupprofilesloaded is predicated to be true');
                      final groupProfiles = groupProfile_state.profiles;
                      return Column(
                        children: [
                          _SearchBar(),
                          _NewUsers(newUsers: newUsers),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: defaultBoxShadow,
                                    color: primaryColor100),
                                width: screenWidth,
                                padding: const EdgeInsets.all(15),
                                child: ListView.builder(
                                  itemCount: rooms.length,
                                  itemBuilder: (context, index) {
                                    final room = rooms[index];
                                    final group_profile =
                                        groupProfiles[room.id];

                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () => Navigator.of(context)
                                              .push(ChatPage.route(
                                                  room.id, room.roomName)),
                                          leading: CircleAvatar(
                                            child: group_profile == null
                                                ? preloader
                                                : Text(group_profile.roomName
                                                    .substring(0, 2)),
                                          ),
                                          title: Text(group_profile == null
                                              ? 'Loading...'
                                              : group_profile.roomName),
                                          subtitle: room.lastMessage != null
                                              ? Text(
                                                  room.lastMessage!.content,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : const Text('Room created'),
                                          trailing: Text(format(
                                              room.lastMessage?.createdAt ??
                                                  room.createdAt,
                                              locale: 'en_short')),
                                        ),
                                        Divider(),
                                      ],
                                    );
                                  },
                                ),
                              ),
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
                        child: Text('No Texting History'),
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
      ),
    );
  }
}

// Frequently interacted with Users ============================================
class _NewUsers extends StatelessWidget {
  const _NewUsers({
    Key? key,
    required this.newUsers,
  }) : super(key: key);

  final List<Profile> newUsers;

  @override
  Widget build(BuildContext context) {
    final otherUsersController = Get.put(OtherUsersController());

    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: defaultBoxShadow,
            color: primaryColor100),
        width: width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: newUsers
                .map<Widget>((user) => InkWell(onTap: () async {
                      try {
                        final roomId = await BlocProvider.of<RoomCubit>(context)
                            .createRoom(user.id, user.username);
                        Navigator.of(context)
                            .push(ChatPage.route(roomId, user.username));
                      } catch (err) {
                        context.showErrorSnackBar(
                            message: 'Failed creating a new room');
                      }
                    }, child: Builder(builder: (context) {
                      final Future<String> firebase_avatar_future =
                          getUserProfileImage(user.id);
                      return FutureBuilder(
                          future: firebase_avatar_future,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                      10,
                                      0,
                                      10,
                                      0,
                                    ),
                                    child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            snapshot.data as String)),
                                  ),
                                  const SizedBox(height: 5),
                                  FutureBuilder(
                                      future: getUserData(user.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            UserModel userData =
                                                snapshot.data as UserModel;
                                            return Text(userData.username,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10,
                                                    color: textColor600),
                                                softWrap: false,
                                                overflow:
                                                    TextOverflow.ellipsis);
                                          }
                                        }
                                        return const Text('loading ...',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                                color: textColor600),
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis);
                                      })
                                ],
                              );
                            }
                            return const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  10,
                                  0,
                                  10,
                                  0,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      ExactAssetImage(defaultProfileImage),
                                ));
                          });
                    })))
                .toList(),
          ),
        ),
      ),
    );
  }
}

// Message Search Bar ==========================================================
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: defaultBoxShadow,
            color: primaryColor100),
        child: TextFormField(
          controller: TextEditingController(),
          onChanged: (query) {
            _filter_groups(query);
          },
          maxLines: 1,
          style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: textColor600),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
              fillColor: primaryColor100,
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(
                  Icons.search_outlined,
                  color: primaryColor600,
                  size: 20,
                ),
              ),
              hintText: 'Search People/ Groups ... ',
              focusColor: primaryColor600),
        ),
      ),
    );
  }
}

_filter_groups(String input) {}

Future<String> getUserProfileImage(String id) async {
  print('get_user_firebase_id called');
  final data = await supabase
      .from('profiles')
      .select('firebase_user_id')
      .match({'id': id}).single();
  //data.then(print('data fetched: ${data.toString()}'));
  //final firebase_user_id = data.then((value) => value['firebase_user_id']);
  //print('firebase_user_id is $firebase_user_id');
  final firebase_id = await data['firebase_user_id'];
  final user_controller = Get.put(OtherUsersController());
  return await user_controller.getUserProfileImage(firebase_id);
}

Future<UserModel> getUserData(String id) async {
  print('get_user_firebase_id called');
  final data = await supabase
      .from('profiles')
      .select('firebase_user_id')
      .match({'id': id}).single();
  //data.then(print('data fetched: ${data.toString()}'));
  //final firebase_user_id = data.then((value) => value['firebase_user_id']);
  //print('firebase_user_id is $firebase_user_id');
  final firebase_id = await data['firebase_user_id'];
  final user_controller = Get.put(OtherUsersController());
  return await user_controller.getUserData(firebase_id);
}
