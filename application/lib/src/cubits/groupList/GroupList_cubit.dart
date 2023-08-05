import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/Searchable.dart';
import '../../models/room.dart';
import '../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../repository/user_repository/UserRepository.dart';
import '../../utils/constants.dart';
import '../returnList/ReturnList_cubit.dart';

part 'GroupList_state.dart';
class GroupListCubit extends ReturnListCubit {
  GroupListCubit() : super();
  List<Room?> _search_result = [];

  Future<List<Searchable?>> fetchGroup(String input) async {

    //print(_myUserId);
    try{
      print('inside fetchGroup try block');
      final firebase_auth = Get.put(AuthenticationRepository());
      final _firebase_uid = await firebase_auth.getCurrentUserUID();
      final cur_user = await Get.put(UserRepository()).getUserData(_firebase_uid!);

      final raw_result = await supabase.from('rooms')
          .select()
          .not('name','eq', cur_user.username)
          .eq('is_private', false)
          .ilike('name','%$input%')
          .limit(20);
      final rows = List<Map<String, dynamic>>.from(raw_result);
      _search_result = rows.map(Room.fromRoom).toList();
      _search_result.forEach((ele) {
        print(ele?.roomName);
      });
    }catch(err){
      emit(GroupListError(err.toString()));
    }
    emit(GroupListLoaded(_search_result));
    return _search_result;
  }
}