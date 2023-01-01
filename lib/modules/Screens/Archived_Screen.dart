import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/Task_Container.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var archived = AppCubit.get(context).archivedTasks;
        return ListView.separated(
            itemBuilder: (context,index){
              return TaskConainer(model: archived[index]);
            },
            separatorBuilder: (context,index){
              return Container(
                height: 0.5,
                width: double.infinity,
              );
            },
            itemCount: archived.length
        );
      },
    );
  }
}
