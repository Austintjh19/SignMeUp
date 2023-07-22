import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/models/room.dart';
import 'package:myapplication/src/utils/constants.dart';

import '../../repository/authentication_repository/AuthenticationRepository.dart';
part 'groupList_state.dart';

class GroupListCubit extends Cubit<GroupListState>{
  GroupListCubit() : super(InitialGroupListState());
  List<Room?> _search_result = [];
  late final String _myUserId;
  initialiseGroupList() async {
    final firebase_auth = Get.put(AuthenticationRepository());
    String? firebase_uid = await firebase_auth.getCurrentUserUID();
    _myUserId = await supabase.rpc(
    'convert_to_uuid', params: {'input_value': firebase_uid});
  }
  Future<void> fetchGroups(String input) async {
    _myUserId = supabase.auth.currentUser!.id;
    try{
      _search_result = await supabase.from('rooms')
          .stream(primaryKey: ['id'])
          .where((ele) {
            String group_name = ele.first['name'];
            return group_name.startsWith(input);
          } )
          .map((ele) => Room.fromRoom(ele.first))
          .toList();
    }catch(err){
      emit(GroupListError(err.toString()));
    }
    emit(GroupListLoaded(_search_result));
  }
}



