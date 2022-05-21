import 'package:flutter/material.dart';
import 'package:tasksapp/businesslogic/appcubit/app_cubit.dart';
import 'package:tasksapp/presentaion/widget/custombootmsheet.dart';
import 'package:tasksapp/presentaion/widget/customtextformfield.dart';
import 'package:tasksapp/shared/colors.dart';
import 'package:tasksapp/shared/strings.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var scafoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  TimeOfDay now = TimeOfDay.now();
  TimeOfDay? tasktime;
  DateTime? taskday;

  bool isshowbottomsheet = false;
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var daycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
        create: (context) => AppCubit()..createDatabase(context),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit appcubit = AppCubit.get(context);

            return Form(
              key: formkey,
              child: Scaffold(
                key: scafoldkey,
                extendBody: true,
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: maincolor,
                  title: Text(appcubit.titels[appcubit.currentindex]),
                  centerTitle: true,
                ),
                bottomNavigationBar: BottomNavigationBar(
                    enableFeedback: true,
                    iconSize: 30,
                    elevation: .3,
                    backgroundColor: Colors.white70,
                    selectedItemColor: maincolor,
                    showSelectedLabels: true,
                    unselectedItemColor: seccolor,
                    type: BottomNavigationBarType.fixed,
                    onTap: (i) {
                      appcubit.changeindex(i);
                    },
                    currentIndex: appcubit.currentindex,
                    items: [
                      BottomNavigationBarItem(
                        label: archivedtasks,
                        icon: const Icon(Icons.archive),
                      ),
                      BottomNavigationBarItem(
                        label: alltasks,
                        icon: const Icon(Icons.menu),
                      ),
                      BottomNavigationBarItem(
                        label: donetasks,
                        icon: const Icon(Icons.check_circle_outline),
                      ),
                    ]),
                floatingActionButtonAnimator:
                    FloatingActionButtonAnimator.scaling,
                floatingActionButton: Visibility(
                  visible: true,
                  child: FloatingActionButton(
                    autofocus: false,
                    clipBehavior: Clip.hardEdge,
                    backgroundColor: maincolor,
                    onPressed: () {},
                    isExtended: false,
                    child: IconButton(
                        onPressed: () {
                          if (isshowbottomsheet) {
                            if (formkey.currentState!.validate()) {
                              appcubit
                                  .insertToDatabase(
                                title: titlecontroller.text,
                                time: timecontroller.text,
                                day: daycontroller.text,
                              )
                                  .then((value) {
                                appcubit
                                    .getDataFromDatabase(appcubit.database)
                                    .then((value) {
                                  appcubit.mytask = value;
                                });
                              });

                              Navigator.pop(context);
                              isshowbottomsheet = false;
                              appcubit.changicon(Icons.add);
                            } 
                          } else {
                            showBottomSheet(context);
                            isshowbottomsheet = true;
                            appcubit.changicon(Icons.done_outline);

                            titlecontroller.clear();
                            timecontroller.clear();
                            daycontroller.clear();
                          }
                        },
                        icon: Icon(appcubit.fabicon)),
                    elevation: 0.0,
                  ),
                ),
                body: ConditionalBuilder(
                  condition: appcubit.mytask.isNotEmpty,
                  builder: (context) => appcubit.screens[appcubit.currentindex],
                  fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: maincolor,
                  )),
                ),
              ),
            );
          },
        ));
  }

// bottom sheet
  void showBottomSheet(BuildContext context) {
    scafoldkey.currentState
        ?.showBottomSheet((context) {
          return CustomBottomSheet(
            widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                      prefix: Icons.title,
                      type: TextInputType.name,
                      controller: titlecontroller,
                      label: tasktitle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      }),
                  CustomTextField(
                      type: TextInputType.number,
                      ontap: () async {
                        tasktime = await showTimePicker(
                            context: context, initialTime: now);
                        if (tasktime == null) {
                          timecontroller.text =
                              '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period.name.toString()}';
                        } else {
                          timecontroller.text =
                              '${tasktime?.hour.toString().padLeft(2, '0')}:${tasktime?.minute.toString().padLeft(2, '0')} ${tasktime?.period.name.toString()}';
                        }
                      },
                      controller: timecontroller,
                      prefix: Icons.alarm,
                      label: date,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      }),
                  CustomTextField(
                      type: TextInputType.number,
                      ontap: () async {
                        taskday = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2024-01-01'));
                        if (taskday == null) {
                          daycontroller.text = DateFormat.yMMMd()
                              .format(DateTime.now())
                              .toString();
                        } else {
                          daycontroller.text =
                              DateFormat.yMMMd().format(taskday!).toString();
                        }
                      },
                      controller: daycontroller,
                      prefix: Icons.calendar_month,
                      label: day,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        } else {
                          return null;
                        }
                      })
                ],
              ),
            ),
          );
        })
        .closed
        .then((value) {
          isshowbottomsheet = false;
          BlocProvider.of<AppCubit>(context).fabicon = Icons.add;
          // setState(() {
          //   fabicon =
          // });
        });
  }
}
