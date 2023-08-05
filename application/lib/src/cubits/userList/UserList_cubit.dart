
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/Searchable.dart';
import '../../models/profile.dart';
import '../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../repository/user_repository/UserRepository.dart';
import '../../utils/constants.dart';
import '../returnList/ReturnList_cubit.dart';
part 'UserList_state.dart';
class UserListCubit extends ReturnListCubit{
  UserListCubit() : super();
  List<Profile?> _search_result = [];
  Future<List<Searchable?>> fetchUsers(String input) async {
    try {
      print('inside fetchUsers try block');
      final firebase_auth = Get.put(AuthenticationRepository());
      final _firebase_uid = await firebase_auth.getCurrentUserUID();
      final cur_user = await Get.put(UserRepository()).getUserData(_firebase_uid!);

     final raw_result = await supabase.from('profiles')
        .select()
        .not('username','eq', cur_user.username)
        .ilike('username','%$input%');
     print('reached here');
      final rows = List<Map<String, dynamic>>.from(raw_result);
      _search_result = rows.map(Profile.fromMap).toList();
      print('userlist search result: $_search_result');
      _search_result.forEach((ele) {
       print(ele?.username);
      });
  }catch(err){
    emit(UserListError(err.toString()));
  }
  emit(UserListLoaded(_search_result));
  return _search_result;
  }
}