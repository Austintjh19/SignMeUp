part of 'ReturnList_cubit.dart';
@immutable


abstract class ReturnListState {
}
class InitialReturnListState extends ReturnListState{}

class ReturnListFetching extends ReturnListState{

}
class ReturnListLoaded extends ReturnListState{
  ReturnListLoaded(this.list){
    print(this.list);
  }
  final List<Searchable?> list;
}
class ReturnListEmpty extends ReturnListState{
}
class ReturnListError extends ReturnListState{
  ReturnListError(this.err_msg){}
  String err_msg;
}
/// ------------Group List
/* abstract class GroupListState extends ReturnListState{}

class InitialGroupListState extends GroupListState{}

class GroupListFetching extends GroupListState{

}
class GroupListLoaded extends GroupListState{
  GroupListLoaded(this.list){}
  final List<Room?> list;
}

class GroupListError extends GroupListState{
  GroupListError(this.err_msg){}
  String err_msg;
}


abstract class UserListState extends ReturnListState{}

class InitialUserListState extends UserListState{}

class UserListFetching extends UserListState{

}
class UserListLoaded extends UserListState{
  UserListLoaded(this.list){}
  final List<Profile?> list;
}

class UserListError extends UserListState{
  UserListError(this.err_msg){}
  String err_msg;
}*/