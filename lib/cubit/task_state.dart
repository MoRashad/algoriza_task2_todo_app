part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskDatabaseInitialized extends TaskState {}

class TaskCreateDatabaseState extends TaskState {}

class InsertIntoDatabase extends TaskState {}

class AppGetDatabaseState extends TaskState {}

class AppDeleteDatabaseState extends TaskState {}

class TaskDatabaseLoaded extends TaskState {}

class TaskUpdateDatabase extends TaskState {}
