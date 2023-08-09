import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/utils/constants.dart';

import '../../../../components/Group_avatar.dart';
import '../../../../components/user_avatar.dart';
import '../../../../cubits/rooms/rooms_cubit.dart';
import '../../../../models/profile.dart';
import '../../../../models/room.dart';
import '../../../../repository/authentication_repository/AuthenticationRepository.dart';
import 'chat_page.dart';

abstract class SearchTile extends StatelessWidget {
}
class UserTile extends SearchTile {
  late final Profile? user;
  UserTile({required Profile? user}){
    this.user = user;
  }

  @override
  Widget build(BuildContext context){
    return ListTile(
      subtitle: Text('User'),
        leading: UserAvatar(userId: user!.id, firebase_user_id: user!.firebase_user_id, radius: 25,),
        title: Text(user!.username),
        trailing: InkWell(onTap: () async{
          try {
            print('button pressed');
            final roomId = await BlocProvider.of<RoomCubit>(context)
                .createRoom(user!.id, user!.username);
            Navigator.of(context)
                .push(ChatPage.route(roomId, user!.username));
            print('push page called');
          } catch (err) {
            context.showErrorSnackBar(
                message: 'Failed creating a new room');
          }
        },
          child: const CircleAvatar(child: Icon(Icons.add)),)
    );
    
  }
}
class GroupTile extends SearchTile {
  late final Room? group;
  GroupTile({required Room? group}){
    this.group = group;
  }
  @override
  Widget build(BuildContext context){
    return ListTile(
      subtitle: Text('Group'),
        leading: GroupAvatar( roomId: group!.id),
        title: Text(group!.roomName),
        trailing: InkWell(onTap: () async{
          final firebase_auth = Get.put(AuthenticationRepository());
          String? firebase_uid = await firebase_auth.getCurrentUserUID();
          final uuid = await supabase.rpc(
              'convert_to_uuid', params: {'input_value': firebase_uid});
          BlocProvider.of<RoomCubit>(context).joinRoom(uuid, group!.id);
          context.showSnackBar(message: 'room joined', backgroundColor: Colors.green,);
        },
          child: const CircleAvatar(child: Icon(Icons.add)),),
    );
      
  }
}