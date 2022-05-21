part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksNew extends TasksState {}

class TasksArchived extends TasksState {}

class TasksDone extends TasksState {}
