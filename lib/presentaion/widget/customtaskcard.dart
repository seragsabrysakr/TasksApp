import 'package:flutter/material.dart';
import 'package:tasksapp/businesslogic/appcubit/app_cubit.dart';
import 'package:tasksapp/presentaion/widget/customtext.dart';
import 'package:tasksapp/shared/colors.dart';

class CustomTaskCard extends StatelessWidget {
  final Map task;
  final checkcolor;
  final archcolor;

  const CustomTaskCard(
      {Key? key,
      required this.task,
      required this.checkcolor,
      required this.archcolor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDatabase(task['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * .11,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.height * .05,
                    width: MediaQuery.of(context).size.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        color: Colors.white,
                        data: task['time'],
                      ),
                    ),
                  )),
              Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: CustomText(
                      size: 30,
                      color: maincolor,
                      weight: FontWeight.bold,
                      data: task['title'],
                    ),
                  ),
                  CustomText(
                    color: Colors.grey,
                    weight: FontWeight.bold,
                    data: task['day'],
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'done', id: task['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: checkcolor,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'archived', id: task['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: archcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
