import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/Screens/Archived_Screen.dart';
import '../../modules/Screens/Done_Screen.dart';
import '../../modules/Screens/Task_Screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  Database? database;
  bool isBottomSheetShown = false;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Widget> screens  = [
    TaskScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  List<String> titles = [
    'Tasks Page',
    'Done Page',
    'Archived Page',
  ];
  int currentIndex = 0;
  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeState());
  }

  void CreateDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          database.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, time Text, date Text,status Text)')
              .then((value) {
            print('database opened');
          });
        },
        onOpen: (database) {
           getFromDatabase(database);
        }
       ).then((value){
        database = value;
       emit(AppCreateDataBaseState());
       });
  }
  
  InsertDatabase({
@required String? title,
@required String? time,
@required String? date,

}) async {
    await database!.transaction((txn) async {
      await txn.rawInsert('INSERT INTO Tasks(title, time, date,status) VALUES("$title", "$time", "$date","new")').then((value){
        print('Table Create ${value.toString()}');
        getFromDatabase(database);
        emit(AppInsertDataBaseState());
      }).catchError((Error){
        print('${Error}');
      });

    });
  }
  
  void getFromDatabase(database){
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

   emit(AppGetLoadingDataBaseState());

    database.rawQuery('SELECT * FROM Tasks').then((value) {

      value.forEach((element)
      {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] == 'done')
          doneTasks.add(element);
        else archivedTasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }
  void updateDatabase(
  {
  @required String? status,
    @required int? id,
}
      ){
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getFromDatabase(database);
          emit(AppUpdateDataBaseState());
    });
  }
  void deleteDatabase(
      {
        @required int? id,
      }
      ){
    database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }
  IconData fabIcon = Icons.edit;
  void changeBottomSheet(
      @required bool isShow,
      @required IconData icon,
      ){
     isBottomSheetShown = isShow;
     fabIcon = icon;
    emit(AppChangeBottomState());
  }
}