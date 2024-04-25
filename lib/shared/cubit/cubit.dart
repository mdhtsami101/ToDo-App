

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/moduls/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_app/moduls/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/moduls/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';



class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titels = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isShowBottomSheet = false;
  IconData floIcon = Icons.edit;

  void changeIndex(int index){
    currentIndex=index;
    emit(AppBottomNavBarState());
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
}){
    isShowBottomSheet =isShow;
    floIcon=icon;
    emit(AppBottomSheetState());
  }

  void createDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, veversion) {
        print('database created');
        database
            .execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , data TEXT ,time TEXT ,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Whene Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);

        print('database opened');
      },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());


    });
  }

 insertDatabase(
      {required String title,
        required String time,
        required String date}) async {
     await database.transaction((txn) =>
         txn.rawInsert(
        'INSERT INTO tasks(title , data , time , status) VALUES("$title","$date","$time","new")')
        .then((value) {
      print('${value}inserted successfully');
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Inserting New Record ${error}');
    }));
  }

  void getDataFromDatabase(database)  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
     database.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element) {
         if(element['status'] == 'new')
           newTasks.add(element);
         else if(element['status'] == 'done')
           doneTasks.add(element);
         else archivedTasks.add(element);
       });
       emit(AppGetDatabaseState());
     });
  }

  void updateData({
    required String status ,
    required int id ,
}) async{
     database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [ '$status' ,id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());

     });
  }

  void deleteData({

    required int id ,
  }) async{
    database.rawDelete(
      'DELETE from tasks WHERE id = ?', [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());

    });
  }


}



