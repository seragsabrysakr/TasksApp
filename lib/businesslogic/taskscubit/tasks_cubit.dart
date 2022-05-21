import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  TasksCubit get(context) => BlocProvider.of(context);
}
