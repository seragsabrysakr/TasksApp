import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/presentaion/screens/navbar/archivedtasks.dart';
import 'package:tasksapp/presentaion/screens/navbar/donetasks.dart';
import 'package:tasksapp/presentaion/screens/navbar/tasksscreen.dart';
import 'package:tasksapp/shared/strings.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
//tasks map
  List<Map> mytask = [];
  //floating icon
  IconData fabicon = Icons.add;
//bottoomsheet index
  int currentindex = 1;
  //home screens
  List<Widget> screens = [
    const ArchivedTasks(),
    const Tasks(),
    const DoneTasks(),
  ];
  //appbar titles
  List<String> titels = [
    archivedtasks,
    tasks,
    donetasks,
  ];
  //change index
  void changeindex(int i) {
    currentindex = i;
    emit(AppChangeBottomsheet());
  }

  //change icon
  void changicon(IconData icon) {
    fabicon = icon;
    emit(AppChangeIcon());
  }

  Database? database;

  // creating Database
  createDatabase(BuildContext context) {
    openDatabase('tasks.db', version: 1, onCreate: (db, version) {
      db
          .execute(
            '''CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT,time TEXT,day TEXT,status TEXT)''',
          )
          .then((value) {})
          .catchError((error) {});
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        mytask = value;
        emit(DatabaseGetdata());
      });
    }).then((value) {
      database = value;
      emit(DatabaseCreated());
      return null;
    });
  }

//insert to Database
  Future insertToDatabase({
    required String title,
    required String time,
    required String day,
  }) async {
    await database
        ?.transaction((txn) async {
          txn.rawInsert(
              '''INSERT INTO task (title,time,day,status) VALUES("$title", "$time","$day","new")''');
        })
        .then((value) => emit(DatabaseInsertData()))
        .catchError((e) {});
    return null;
  }

  //getdata from Database
  Future<List<Map>> getDataFromDatabase(database) async {
    List<Map> tasks = await database.rawQuery('SELECT * FROM task');

    return tasks;
  }

  updateFromDatabase() {}
  deleteFromDatabase() {}
}
