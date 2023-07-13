import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/models/message.dart';
import 'package:myapplication/src/models/room.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    try {
      await supabase.auth.signInWithPassword(
        email: 'haitaowang076@gmail.com',
        password:'123456'
      );
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
    _haveCalledGetRooms = true;

    _myUserId = supabase.auth.currentUser!.id;

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
      for (final room in _rooms) {
        _getNewestMessage(context: context, roomId: room.id);
        // temporary measure such that the first user in the room is stubbed as chat icon
        //BlocProvider.of<ProfilesCubit>(context).getProfile(room.members[0]);
        BlocProvider.of<GroupProfilesCubit>(context).getProfile(room.id);
      }
      for (final user in _newUsers){
        BlocProvider.of<UserProfilesCubit>(context).getProfile(user.id);
      }

      emit(RoomsLoaded(
        newUsers: _newUsers,
        rooms: _rooms,
      ));
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
        .rpc('create_new_room', params: {'other_user_id': otherUserId, 'other_user_name': otherUserName});
    emit(RoomsLoaded(rooms: _rooms, newUsers: _newUsers));
    return data as String;
  }
  /// allow user to join an existing chat room
  Future<void> joinRoom(String userId, String roomId) async {
    await supabase.rpc('join_room', params: {'joining_user': userId, 'room_id': roomId});
    emit(RoomsLoaded(rooms: _rooms, newUsers: _newUsers));
  }

  @override
  Future<void> close() {
    _rawRoomsSubscription?.cancel();
    return super.close();
  }
}
