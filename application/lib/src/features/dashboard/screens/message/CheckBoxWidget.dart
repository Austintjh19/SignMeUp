import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapplication/src/cubits/returnList/ReturnList_cubit.dart';

class CheckBoxWidget extends StatefulWidget{
  var is_checked;
  String search_type;
  CheckBoxWidget(this.is_checked,this.search_type,{super.key});
  @override
  State<StatefulWidget> createState() {
    return CheckBoxWidgetState(is_checked,search_type);
  }
}

class CheckBoxWidgetState extends State<CheckBoxWidget>{
  bool is_checked;
  String search_type;

  CheckBoxWidgetState(this.is_checked,this.search_type);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text(search_type),
          Checkbox(
              value: is_checked,
              tristate: false,
              onChanged: (new_value){
                setState(() {
                  is_checked = new_value!;
                  print('$search_type: $is_checked ');
                  if(search_type == 'by user:'){
                    BlocProvider.of<ReturnListCubit>(context).toggle_user();
                  }else {
                    BlocProvider.of<ReturnListCubit>(context).toggle_group();
                  }
                });
              })
        ]
    );
  }

}
