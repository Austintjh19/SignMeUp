import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';
import 'package:myapplication/src/cubits/groupList/GroupList_cubit.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/models/room.dart';
import 'package:myapplication/src/utils/constants.dart';

import '../../models/Searchable.dart';
import '../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../repository/user_repository/UserRepository.dart';
import '../userList/UserList_cubit.dart';
part 'ReturnList_state.dart';

class ReturnListCubit extends Cubit<ReturnListState>{
  bool user_search = true;
  bool group_search = true;
  List<Searchable> _search_result = [];
  late final String? supabase_uuid;
  late final String? _firebase_uid;
  late String Username;
 ReturnListCubit() : super(InitialReturnListState());
  initialiseReturnList() async {

    final firebase_auth = Get.put(AuthenticationRepository());
     _firebase_uid = await firebase_auth.getCurrentUserUID();
    final cur_user = await Get.put(UserRepository()).getUserData(_firebase_uid!);
    Username = cur_user.username;
    supabase_uuid = await supabase.rpc(
        'convert_to_uuid', params: {'input_value': _firebase_uid});
  }
  void toggle_user(){
    user_search = !user_search;
  }
  void toggle_group(){
    group_search = !group_search;
  }
  Future<List<Searchable?>> fetchData(String input, BuildContext context ) async {
    //_supabase_uuid = supabase.auth.currentUser!.id;
    try{
      print('input: $input');
      if(user_search == true ){
        if(group_search == false){
          return await BlocProvider.of<UserListCubit>(context).fetchUsers(input);
        }else {
          final group_list = await BlocProvider.of<GroupListCubit>(context).fetchGroup(input);
          print('group_list: $group_list');
          final user_list = await BlocProvider.of<UserListCubit>(context).fetchUsers(input);
          print('user_list: $user_list');
          return group_list + user_list;
        }
      }else{
        if(group_search == true){
          return await BlocProvider.of<GroupListCubit>(context).fetchGroup(input);
        }else{
          print('please select your searching type :)');
        }
      }
    }catch(err){
      emit(ReturnListError(err.toString()));
    }
    emit(ReturnListLoaded(_search_result));
    return _search_result;
  }
}





