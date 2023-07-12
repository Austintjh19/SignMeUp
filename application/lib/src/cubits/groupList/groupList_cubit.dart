import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapplication/src/models/profile.dart';
import 'package:myapplication/src/models/room.dart';
import 'package:myapplication/src/utils/constants.dart';
part 'groupList_state.dart';

class GroupListCubit extends Cubit<GroupListState>{
  GroupListCubit() : super(InitialGroupListState());
  List<Room?> _search_result = [];
  late final String _myUserId;
  Future<void> fetchGroups(String input) async {
    _myUserId = supabase.auth.currentUser!.id;
    try{
      _search_result = await supabase.from('rooms')
          .stream(primaryKey: ['id'])
          .where((ele) {
            Iterable<String> members = ele.first['members'];
            return members.contains(_myUserId)
                && ele.first['name'].toString().startsWith(input);
          } )
          .map((ele) => Room.fromRoom(ele.first))
          .toList();
    }catch(err){
      emit(GroupListError(err.toString()));
    }
    emit(GroupListLoaded(_search_result));
  }
}



