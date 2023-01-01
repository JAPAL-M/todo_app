import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/Task_Container.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
      builder: (context,state){
          var tasks = AppCubit.get(context).newTasks;
          return ListView.separated(
              itemBuilder: (context,index){
                return TaskConainer(model: tasks[index]);
              },
              separatorBuilder: (context,index){
                return Container(
                  height: 0.5,
                  width: double.infinity,
                );
              },
              itemCount: tasks.length
          );
      },
    );
  }
}
