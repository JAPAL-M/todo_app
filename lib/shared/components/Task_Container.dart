import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/style/Colors_Const.dart';

class TaskConainer extends StatelessWidget {
  TaskConainer({Key? key, @required this.model}) : super(key: key);
  Map? model;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Dismissible(
      key: Key(model!['id'].toString()),
      onDismissed: (direction){
        cubit.deleteDatabase(id: model!['id']);
      },
      child: Container(
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: SecondColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: MainColor,
              radius: 50,
              child: Text(
                model!['time'], style: TextStyle(color: SecondColor),),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(model!['title'],
                    style: TextStyle(color: Colors.white, fontSize: 18),),
                  Text(model!['date'],
                    style: TextStyle(color: Colors.grey[400]),),
                ],
              ),
            ),
            IconButton(onPressed: () {
              cubit.updateDatabase(status: 'done', id: model!['id']);
            }, icon: Icon(Icons.check_box, color: MainColor,)),
            IconButton(onPressed: () {
              cubit.updateDatabase(status: 'archived', id: model!['id']);
            }, icon: Icon(Icons.archive, color: Colors.grey[400],))
          ],
        ),
      ),
    );
  }
}
