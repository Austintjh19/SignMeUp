part of 'GroupList_cubit.dart';
abstract class GroupListState extends ReturnListState{}

class InitialGroupListState extends GroupListState{}

class GroupListFetching extends GroupListState{

}
class GroupListEmpty extends GroupListState{

}
class GroupListLoaded extends GroupListState{
  GroupListLoaded(this.list){}
  final List<Room?> list;
}

class GroupListError extends GroupListState{
  GroupListError(this.err_msg){}
  String err_msg;
}