import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/cubits/profiles/profiles_cubit.dart';
import 'package:myapplication/src/utils/constants.dart';

/// Widget that will display a group's avatar
class GroupAvatar extends StatelessWidget {
  const GroupAvatar({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupProfilesCubit, ProfilesState>(
      builder: (context, state) {
        if (state is GroupProfilesLoaded) {
          final group = state.profiles[roomId];
          return CircleAvatar(
            child:
            group == null ? preloader : Text(group.roomName.substring(0, 2)),
            radius: 25,
          );
        } else {
          return const CircleAvatar(child: preloader);
        }
      },
    );
  }
}
