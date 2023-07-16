import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/features/dashboard/controllers/CurrentUserController.dart';
import 'package:myapplication/src/features/dashboard/controllers/OtherUsersController.dart';
import 'package:myapplication/src/utils/constants.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

/// Widget that will display a user's avatar
class UserAvatar extends StatelessWidget {
  UserAvatar({
    Key? key,
    required this.userId,
    required this.firebase_user_id,
  }) : super(key: key);

  final String firebase_user_id;
  final String userId;
  static Map<String, Widget> _user_profile_cache = {};

  @override
  Widget build(BuildContext context) {
    final user_controller = Get.put(OtherUsersController());
    if(_user_profile_cache[userId] != null) {
      return _user_profile_cache[userId]!;
    }
    return FutureBuilder(
        future: user_controller.getUserProfileImage(firebase_user_id),
        builder: (context, snapshot) {
          print('snapshot' + snapshot.connectionState.toString());
          if(snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print('snapshot.data:' + (snapshot.data as String));
              final ret = CircleAvatar(
                  child: Image.network(snapshot
                      .data as String) /*Text(user.username.substring(0, 2)) */
              );
              _user_profile_cache[userId] = ret;
              return ret;
            }
            else{
              return CircularProgressIndicator();
            }
          }else {
            return CircularProgressIndicator();
          }
        }
    );



      /*BlocBuilder<UserProfilesCubit, ProfilesState>(
      builder: (context, state) {
        if (state is UserProfilesLoaded) {
          print('blocbuilder for avatar called');
          final user = state.profiles[userId];
          print('user is $user');
          final ret = FutureBuilder(
            future: current_user_controller.getProfileImage(),
            builder: (context, snapshot) {
                print('snapshot' + snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  print('snapshot connection state done detected');
                  return CircleAvatar(
                      child:  Image.network(snapshot.data as String ) /*Text(user.username.substring(0, 2)) */
                  );
                }
                return Text(user!.username.substring(0, 2));
            }
          );
          print('ret:' +ret.toString() );
          _user_profile_cache[userId] = ret;
          print('after adding a cached user' + _user_profile_cache.toString());
          return ret;
        } else {
          if(_user_profile_cache[userId] != null) {
            return _user_profile_cache[userId]!;
          }else {
            print('nothing found in cache');
            print("cache:" + _user_profile_cache.toString());
            return const CircleAvatar(child: preloader);
          }
        }
      },
    );*/
  }
}
