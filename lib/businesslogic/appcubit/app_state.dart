part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomsheet extends AppState {}

class AppChangeIcon extends AppState {}
class AppChangeIconColor extends AppState {}

class DatabaseCreated extends AppState {}

class DatabaseInsertData extends AppState {}

class DatabaseGetdata extends AppState {}

class DatabaseUpdateData extends AppState {}
class DeleteDatabaseState extends AppState {}
