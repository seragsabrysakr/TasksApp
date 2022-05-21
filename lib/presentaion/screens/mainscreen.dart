import 'package:flutter/material.dart';
import 'package:tasksapp/presentaion/screens/navbar/archivedtasks.dart';
import 'package:tasksapp/presentaion/screens/navbar/donetasks.dart';
import 'package:tasksapp/presentaion/screens/navbar/tasksscreen.dart';
import 'package:tasksapp/presentaion/widget/custombootmsheet.dart';
import 'package:tasksapp/presentaion/widget/customtextformfield.dart';
import 'package:tasksapp/shared/colors.dart';
import 'package:tasksapp/shared/strings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

final List<Widget> screens = [
  const ArchivedTasks(),
  const Tasks(),
  const DoneTasks(),
];
var scafoldkey = GlobalKey<ScaffoldState>();
var formkey = GlobalKey<FormState>();

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  Database? database;

  TimeOfDay now = TimeOfDay.now();
  TimeOfDay? tasktime;
  DateTime? taskday;

  int currentindex = 1;
  bool isshowbottomsheet = false;
  IconData fabicon = Icons.add;
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var daycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        key: scafoldkey,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: maincolor,
          title: Text(tasks),
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
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            },
            currentIndex: currentindex,
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
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
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
                      print(titlecontroller.text);
                      print(timecontroller.text);
                      print(daycontroller.text);
                      insertToDatabase(
                        title: titlecontroller.text,
                        time: timecontroller.text,
                        day: daycontroller.text,
                      );
                      Navigator.pop(context);
                      isshowbottomsheet = false;
                      setState(() {
                        fabicon = Icons.add;
                      });
                    }
                  } else {
                    showBottomSheet();
                    isshowbottomsheet = true;
                    setState(() {
                      fabicon = Icons.done_outline;
                    });
                    titlecontroller.clear();
                    timecontroller.clear();
                    daycontroller.clear();
                  }
                },
                icon: Icon(fabicon)),
            elevation: 0.0,
          ),
        ),
        body: Center(
          child: IconButton(
              onPressed: () {
                insertToDatabase(
                  title: 'srag',
                  time: '2',
                  day: '44',
                );
              },
              icon: const Icon(Icons.abc)),
        ),
      ),
    );
  }

  void showBottomSheet() {
    scafoldkey.currentState?.showBottomSheet((context) {
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
                      setState(() {
                        timecontroller.text =
                            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period.name.toString()}';
                      });
                    } else {
                      setState(() {
                        timecontroller.text =
                            '${tasktime?.hour.toString().padLeft(2, '0')}:${tasktime?.minute.toString().padLeft(2, '0')} ${tasktime?.period.name.toString()}';
                      });
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
                      setState(() {
                        daycontroller.text = DateFormat.yMMMd()
                            .format(DateTime.now())
                            .toString();
                      });
                    } else {
                      setState(() {
                        daycontroller.text =
                            DateFormat.yMMMd().format(taskday!).toString();
                      });
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
    });
  }

  createDatabase() async {
    database =
        await openDatabase('tasks.db', version: 1, onCreate: (db, version) {
      print('datapase created');
      db.execute(
        '''CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT,time TEXT,day TEXT,status TEXT)''',
      ).then((value) {
        print('table created ');
      }).catchError((error) {});
    }, onOpen: (database) {
      print('database opend $database');
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String day,
  }) async {
    database
        ?.transaction((txn) async {
          txn.rawInsert(
              '''INSERT INTO task (title,time,day,status) VALUES("$title", "$time","$day","new")''');
        })
        .then((value) => print(value))
        .catchError((e) {
          print('error is $e');
        });
    return null;
  }

  updateFromDatabase() {}
  deleteFromDatabase() {}
}
