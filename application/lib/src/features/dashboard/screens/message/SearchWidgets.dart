import 'package:flutter/cupertino.dart';

import '../../../../models/profile.dart';
import '../../../../models/room.dart';

abstract class SearchTile extends StatelessWidget {
}
class UserTile extends SearchTile {
  UserTile({required Profile? users});

  @override
  Widget build(BuildContext context){
    return Placeholder(child: Text('usertile placeholder'),);
  }
}
class GroupTile extends SearchTile {
  GroupTile({required Room? groups});

  @override
  Widget build(BuildContext context){
    return Placeholder(child: Text('grouptile placeholder'),);
  }
}