import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/models/message.dart';
import 'package:myapplication/src/models/room.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';
part 'rooms_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomsLoading());

  final Map<String, StreamSubscription<Message?>> _messageSubscriptions = {};
  late final String _myUserId;

  /// List of new users of the app for the user to start talking to
  late final List<Profile> _newUsers;

  /// List of rooms
  List<Room> _rooms = [];
  StreamSubscription<List<Map<String, dynamic>>>? _rawRoomsSubscription;
  bool _haveCalledGetRooms = false;

  Future<void> initializeRooms(BuildContext context) async {
    if (_haveCalledGetRooms) {
      return;
    }
    //_myUserId = supabase.auth.currentUser!.id;
    _haveCalledGetRooms = true;

    try {
      print("before calling getCurrentUserID()");
      final firebase_auth = Get.put(AuthenticationRepository());
      String? firebase_uid = await firebase_auth.getCurrentUserUID();
      print(firebase_uid);
      //UserModel? cur_user = await UserRepository.instance.getUserData(firebase_uid!);
      final cur_user = await Get.put(UserRepository()).getUserData(firebase_uid!);
     // String firebase_uid = cur_user.uid;
      String email = cur_user.email;
      String password = cur_user.password;
      String username = cur_user.username;
      _myUserId = await supabase.rpc(
          'convert_to_uuid', params: {'input_value': firebase_uid});
      ///this remote procedure call will check if the firebase user is already logged in supabase
      ///profiles table, if not create a new users in auth.users and
      ///public.profiles(this is triggered action from inserting into auth.users and return false)
      bool user_exist = await supabase.rpc('check_uuid_exists', params: {'uid': _myUserId});

      if(user_exist) {
      }else{
        await supabase.rpc('migrate_user', params: {'uid': _myUserId, 'email': email,'password':password,'meta_data':{'username': username, 'firebase_user_id':firebase_uid}});
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (err) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
      print(err);
    }

    late final List data;

    try {
      data = await supabase
          .from('profiles')
          .select()
          .not('id', 'eq', _myUserId)
          .order('created_at')
          .limit(12);
    } catch (_) {
      emit(RoomsError('Error loading new users'));
    }

    final rows = List<Map<String, dynamic>>.from(data);
    _newUsers = rows.map(Profile.fromMap).toList();
    //8/ Get realtime updates on rooms that the user is in
    _rawRoomsSubscription = supabase.from('rooms').stream(
      primaryKey: ['room_id'],
    ).listen((rooms) async {
      if (rooms.isEmpty) {
        emit(RoomsEmpty(newUsers: _newUsers));
        return;
      }
      _rooms = rooms
          .map(Room.fromRoom)
          .where((room) => room.members.contains(_myUserId) )
          .toList();

      for (final user in _newUsers){
        BlocProvider.of<UserProfilesCubit>(context).getProfile(user.id);
      }
      if(_rooms.isEmpty){
        emit(RoomsEmpty(newUsers: _newUsers));
        print('rooms empty emited');
      }
      for (final room in _rooms) {
        _getNewestMessage(context: context, roomId: room.id);
        // temporary measure such that the first user in the room is stubbed as chat icon
        //BlocProvider.of<ProfilesCubit>(context).getProfile(room.members[0]);
        print('rooms' + _rooms.toString());
        BlocProvider.of<GroupProfilesCubit>(context).getProfile(room.id);
        print(room.toString() + 'get profile called');
      }
      if(_rooms.isNotEmpty) {
        emit(RoomsLoaded(
          newUsers: _newUsers,
          rooms: _rooms,
        ));
        print('roomsloaded state emited');
      }

    }, onError: (error) {
      emit(RoomsError('Error loading rooms'));
    });
  }

  // Setup listeners to listen to the most recent message in each room
  void _getNewestMessage({
    required BuildContext context,
    required String roomId,
  }) {
    _messageSubscriptions[roomId] = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at')
        .limit(1)
        .map<Message?>(
          (data) => data.isEmpty
              ? null
              : Message.fromMap(
                  map: data.first,
                  myUserId: _myUserId,
                ),
        )
        .listen((message) {
          final index = _rooms.indexWhere((room) => room.id == roomId);
          _rooms[index] = _rooms[index].copyWith(lastMessage: message);
          _rooms.sort((a, b) {
            /// Sort according to the last message
            /// Use the room createdAt when last message is not available
            final aTimeStamp =
                a.lastMessage != null ? a.lastMessage!.createdAt : a.createdAt;
            final bTimeStamp =
                b.lastMessage != null ? b.lastMessage!.createdAt : b.createdAt;
            return bTimeStamp.compareTo(aTimeStamp);
          });
          if (!isClosed) {
            emit(RoomsLoaded(
              newUsers: _newUsers,
              rooms: _rooms,
            ));
          }
        });
  }

  /// Creates or returns an existing roomID that contains both participants
  Future<String> createRoom(String otherUserId,String otherUserName) async {
    final data = await supabase
        .rpc('create_new_room', params: {'other_user_id': otherUserId, 'other_user_name': otherUserName, 'cur_user_id': _myUserId});
    emit(RoomsLoaded(rooms: _rooms, newUsers: _newUsers));
    return data as String;
  }
  /// allow user to join an existing chat room
  Future<void> joinRoom(String userId, String roomId) async {
    await supabase.rpc('join_room', params: {'joining_user': userId, 'existing_room': roomId});
    //emit(RoomsLoaded(rooms: _rooms, newUsers: _newUsers));
  }

  @override
  Future<void> close() {
    _rawRoomsSubscription?.cancel();
    return super.close();
  }
}
