import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/Task_Container.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/style/Colors_Const.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var done = AppCubit.get(context).doneTasks;
        return ListView.separated(
            itemBuilder: (context,index){
              return TaskConainer(model: done[index]);
            },
            separatorBuilder: (context,index){
              return Container(
                color: SecondColor,
                height: 1,
                width: double.infinity,
              );
            },
            itemCount: done.length
        );
      },
    );
  }
}
