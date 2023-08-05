import 'package:flutter/cupertino.dart';

import '../../../../models/profile.dart';
import '../../../../models/room.dart';

abstract class SearchTile extends StatelessWidget {
}
class UserTile extends SearchTile {
  late final Profile? user;
  UserTile({required Profile? user}){
    this.user = user;
  }

  @override
  Widget build(BuildContext context){
    return Placeholder(child: Text('${user?.username}'),);
  }
}
class GroupTile extends SearchTile {
  late final Room? group;
  GroupTile({required Room? group}){
    this.group = group;
  }
  @override
  Widget build(BuildContext context){
    return Placeholder(child: Text('${group?.roomName}'),);
  }
}