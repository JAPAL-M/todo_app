import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/MyTextFormField.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/style/Colors_Const.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldkey,
              floatingActionButton: FloatingActionButton(
                backgroundColor: MainColor,
                onPressed: () {
                  if(cubit.isBottomSheetShown){
                    if(formkey.currentState!.validate()){
                      cubit.InsertDatabase(
                          title: titlecontroller.text,
                          time: timecontroller.text,
                          date: datecontroller.text
                      );
                    }
                   // Navigator.pop(context);
                  }else{
                    scaffoldkey.currentState!.showBottomSheet((context) =>
                        Container(
                          decoration: BoxDecoration(
                            color: MainColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyTextFormField(
                                      controller: titlecontroller,
                                      label: 'Enter Your Task',
                                      type: TextInputType.text,
                                      icon: Icons.title,
                                      validator: (String? value){
                                        if(value!.isEmpty){
                                          return 'Task is Empty';
                                        }
                                      }
                                  ),
                                  SizedBox(height: 5,),
                                  MyTextFormField(
                                      controller: timecontroller,
                                      label: 'Enter Time',
                                      type: TextInputType.datetime,
                                      icon: Icons.access_time_outlined,
                                      validator: (String? value){
                                        if(value!.isEmpty){
                                          return 'Time is Empty';
                                        }
                                      },
                                      onTap: (){
                                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                          timecontroller.text = value!.format(context).toString();
                                        });
                                      },
                                  ),
                                  SizedBox(height: 5,),
                                  MyTextFormField(
                                      controller: datecontroller,
                                      label: 'Enter Date',
                                      type: TextInputType.datetime,
                                      icon: Icons.calendar_today,
                                      validator: (String? value){
                                        if(value!.isEmpty){
                                          return 'Date is Empty';
                                        }
                                      },
                                    onTap: (){
                                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2024-01-01')).then((value) {
                                          datecontroller.text = DateFormat.yMMMd().format(value!);
                                        });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                    )).closed.then((value) {
                      cubit.changeBottomSheet(false, Icons.edit);
                    });

                    cubit.changeBottomSheet(true, Icons.add);
                  }
                },
                child: Icon(
                  cubit.fabIcon,
                  color: SecondColor,
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
              backgroundColor: MainColor,
              appBar: AppBar(
                elevation: 0.5,
                backgroundColor: MainColor,
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),
                ),
                centerTitle: true,
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.grey[400],
                unselectedItemColor: SecondColor,
                selectedItemColor: MainColor,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      label: 'Tasks', icon: Icon(Icons.task_outlined)),
                  BottomNavigationBarItem(
                      label: 'Done', icon: Icon(Icons.check_circle_outline)),
                  BottomNavigationBarItem(
                      label: 'Archived', icon: Icon(Icons.archive_outlined)),
                ],
              ));
        },
      ),
    );
  }
}
