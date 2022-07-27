// ignore_for_file: depend_on_referenced_packages

import "package:path/path.dart" as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  static TaskCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> newTasks = [];
  List<Map> completedTasks = [];
  List<Map> favouritedTasks = [];
  List<Map> allTasks = [];
  void initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'tasksaapp.db');
    debugPrint('task database initialized');
    openTaskDatabase(path: path);
    emit(TaskDatabaseInitialized());
  }

  void openTaskDatabase({required String path}) {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, status TEXT, favourited TEXT, remind TEXT, color TEXT)')
            .then((value) => debugPrint('Table Created'))
            .catchError((error) =>
                debugPrint('Error When Creating Table ${error.toString()}'));
        debugPrint('Table created');
      },
      onOpen: (Database db) {
        debugPrint('database opened');

        getDataBase(db);
      },
    ).then((value) async {
      database = value;

      emit(TaskCreateDatabaseState());
    });
  }

  void getDataBase(db) async {
    database = db;
    allTasks = [];
    newTasks = [];
    completedTasks = [];
    favouritedTasks = [];
    db.rawQuery('SELECT * FROM tasks').then((value) {
      //print(value);
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'Completed' &&
            element['favourited'] == 'false') {
          completedTasks.add(element);
        } else if (element['status'] == 'Completed' &&
            element['favourited'] == 'true') {
          completedTasks.add(element);
          favouritedTasks.add(element);
        }
        if (element['status'] == 'new' && element['favourited'] == 'true') {
          // newTasks.add(element);
          favouritedTasks.add(element);
        }
        allTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void loadDatabase() {
    getDataBase(database);
    emit(TaskDatabaseLoaded());
  }

  void insetIntoTaskDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    //required String status,
    required String remind,
    required String color,
  }) async {
    database!.transaction(
      (txn) async {
        txn
            .rawInsert(
                'INSERT INTO tasks (title, date, startTime, endTime, status, favourited, remind, color) VALUES ("$title","$date", "$startTime", "$endTime", "new", "false", "$remind", "$color")')
            .then((value) {
          getDataBase(database);

          emit(InsertIntoDatabase());
        }).catchError((error) {
          debugPrint('Error when inserting into data base ${error.toString()}');
        });
      },
    );
  }

  void deleteFromDatabase(int id) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void updateCompleteDatabase(String status, int id) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataBase(database);
      //print('added to favourite');
      emit(TaskUpdateDatabase());
    });
  }

  void updateFavouriteDatabase(String status, int id) {
    database!.rawUpdate('UPDATE tasks SET favourited = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataBase(database);
      // print('added to favourite');
      emit(TaskUpdateDatabase());
    });
  }
}

//
