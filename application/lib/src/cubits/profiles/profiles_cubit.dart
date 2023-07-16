import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:myapplication/src/models/room.dart';
part 'profiles_state.dart';

class UserProfilesCubit extends Cubit<ProfilesState> {
  UserProfilesCubit() : super(ProfilesInitial());

  /// Map of app users cache in memory with profile_id as the key
  final Map<String, Profile?> user_profiles = {};

  Future<Map<String,dynamic>> getUserInfo(String userId) async{
    Map<String, dynamic> userinfo = {'username': user_profiles[userId]?.username};
    emit(UserInfoFetched(userinfo: userinfo));
    return userinfo;
  }

  Future<void> getProfile(String userId) async {
    if (user_profiles[userId] != null) {
      return;
    }


    final data =
        await supabase.from('profiles').select().match({'id': userId}).single();

    if (data == null) {
      return;
    }
    user_profiles[userId] = Profile.fromMap(data);

    emit(UserProfilesLoaded(profiles: user_profiles));
  }
}

class GroupProfilesCubit extends Cubit<ProfilesState> {
  GroupProfilesCubit() : super(ProfilesInitial());

  /// Map of groups cache in memory with room_id as the key
  final Map<String, Room?> _group_profiles = {};

  Future<void> getProfile(String roomId) async {
    print('room getProfile called');
    if (_group_profiles[roomId] != null) {
      return;
    }

    final data =
    await supabase.from('rooms').select().match({'id': roomId}).single();

    if (data == null) {
      return;
    }
    _group_profiles[roomId] = Room.fromRoom(data);

    emit(GroupProfilesLoaded(profiles: _group_profiles));
    print('groupprofileloaded state emited ');
  }
}
