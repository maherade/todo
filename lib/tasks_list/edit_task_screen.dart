import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';

import '../network/local/firebase_utils.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit-task';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var taskData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskData = ModalRoute.of(context)!.settings.arguments as TaskData;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme.lightPrimary,
        title: const Text('Edit Task'),
      ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: mediaQuery.height * 0.11,
              color: MyTheme.lightPrimary,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 40),
                    width: mediaQuery.width * .85,
                    height: mediaQuery.height * .7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: settingsProvider.isDarkMood()
                          ? MyTheme.itemDarkColor
                          : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Task',
                          style: settingsProvider.isDarkMood()
                              ? Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white)
                              : Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  taskData.title = value;
                                },
                                initialValue: taskData.title,
                                style: TextStyle(
                                    color: settingsProvider.isDarkMood()
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: settingsProvider.isDarkMood()
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  taskData.description = value;
                                },
                                initialValue: taskData.description,
                                style: TextStyle(
                                  color: settingsProvider.isDarkMood()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: settingsProvider.isDarkMood()
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Select Date',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        InkWell(
                          onTap: () {
                            showSelectDatePicker();
                          },
                          child: Text(
                            '${taskData!.date!.year}-${taskData!.date!.month}-${taskData!.date!.day}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: MyTheme.lightPrimary),
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minWidth: 255,
                          height: 55,
                          color: MyTheme.lightPrimary,
                          onPressed: () {
                            editTask();
                          },
                          child: Text(
                            'Save Changes',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSelectDatePicker() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: taskData!.date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      setState(() {
        taskData!.date = chosenDate;
      });
    }
  }

  Future<void> editTask() async {
    Navigator.pop(context);
    await editTaskDetails(taskData!);
  }
}
