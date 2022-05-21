import 'package:flutter/material.dart';
import 'package:tasksapp/businesslogic/appcubit/app_cubit.dart';
import 'package:tasksapp/presentaion/widget/customtaskcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var app = AppCubit.get(context);

        return Center(
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  CustomTaskCard(task: app.mytask[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade100,
                    ),
                  ),
              itemCount: app.mytask.length),
        );
      },
    );
  }
}
