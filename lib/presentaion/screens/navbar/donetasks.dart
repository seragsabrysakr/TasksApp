import 'package:flutter/material.dart';
import 'package:tasksapp/businesslogic/appcubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/presentaion/widget/customtaskcard.dart';
import 'package:tasksapp/shared/colors.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var done = AppCubit.get(context).donetask;

        return Center(
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  CustomTaskCard(
                    checkcolor: maincolor,
                    archcolor: Colors.grey,

                    task: done[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade100,
                    ),
                  ),
              itemCount: done.length),
        );
      },
    );
  }
}
