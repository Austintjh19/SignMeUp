part of 'ReturnList_cubit.dart';
@immutable


abstract class ReturnListState {
}
class InitialReturnListState extends ReturnListState{}

class ReturnListFetching extends ReturnListState{

}
class ReturnListLoaded extends ReturnListState{
  ReturnListLoaded(this.list){
    print('returnlistloaded emitted: $this.list');
  }
  final List<Searchable?> list;
}
class ReturnListEmpty extends ReturnListState{
}
class ReturnListError extends ReturnListState{
  ReturnListError(this.err_msg){}
  String err_msg;
}
