
part of 'UserList_cubit.dart';

abstract class UserListState extends ReturnListState{}

class InitialUserListState extends UserListState{}

class UserListFetching extends UserListState{

}
class UserListEmpty extends UserListState{

}
class UserListLoaded extends UserListState{
  UserListLoaded(this.list){}
  final List<Profile?> list;
}

class UserListError extends UserListState{
  UserListError(this.err_msg){}
  String err_msg;
}