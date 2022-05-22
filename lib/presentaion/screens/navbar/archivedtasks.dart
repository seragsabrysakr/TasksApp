import 'package:flutter/material.dart';
import 'package:tasksapp/businesslogic/appcubit/app_cubit.dart';
import 'package:tasksapp/presentaion/widget/customtaskcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/shared/colors.dart';

class ArchivedTasks extends StatefulWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  State<ArchivedTasks> createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var archived = AppCubit.get(context).archtask;

        return Center(
          child: ListView.separated(
              itemBuilder: (context, index) => CustomTaskCard(
                  checkcolor: Colors.grey,
                  archcolor: maincolor,
                  task: archived[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade100,
                    ),
                  ),
              itemCount: archived.length),
        );
      },
    );
  }
}
