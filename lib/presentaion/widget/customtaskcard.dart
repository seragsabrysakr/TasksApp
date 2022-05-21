import 'package:flutter/material.dart';
import 'package:tasksapp/presentaion/widget/customtext.dart';
import 'package:tasksapp/shared/colors.dart';

class CustomTaskCard extends StatelessWidget {
  final Map task;

  const CustomTaskCard({Key? key, required this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
