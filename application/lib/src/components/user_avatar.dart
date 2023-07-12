import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/utils/constants.dart';

/// Widget that will display a user's avatar
class UserAvatar extends StatelessWidget {
  UserAvatar({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;
  static Map<String, Widget> _user_profile_cache = {};
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfilesCubit, ProfilesState>(
      builder: (context, state) {
        if (state is UserProfilesLoaded) {
          final user = state.profiles[userId];
          final ret = CircleAvatar(
            child:
            user == null ? preloader : Text(user.username.substring(0, 2)),
          );
          _user_profile_cache[userId] = ret;
          //print('after adding a cached user' + _user_profile_cache.toString());
          return ret;
        } else {
          if(_user_profile_cache[userId] != null) {
            return _user_profile_cache[userId]!;
          }else {
            //print('nothing found in cache');
            //print("cache:" + _user_profile_cache.toString());
            return const CircleAvatar(child: preloader);
          }
        }
      },
    );
  }
}
