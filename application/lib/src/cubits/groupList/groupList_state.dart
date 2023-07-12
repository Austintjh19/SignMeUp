part of 'groupList_cubit.dart';
@immutable
abstract class GroupListState {}

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