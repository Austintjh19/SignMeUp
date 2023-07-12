part of 'profiles_cubit.dart';

@immutable
abstract class ProfilesState {}

class ProfilesInitial extends ProfilesState {}

class UserProfilesLoaded extends ProfilesState {
  UserProfilesLoaded({
    required this.profiles,
  }) {
    print(profiles);
  }

  final Map<String, Profile?> profiles;
}
class UserInfoFetched extends ProfilesState{
  UserInfoFetched({required this.userinfo});
  final Map<String,dynamic> userinfo;
}
class GroupProfilesLoaded extends ProfilesState {
  GroupProfilesLoaded({
    required this.profiles,
  });

  final Map<String, Room?> profiles;
}
