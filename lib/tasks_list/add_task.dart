import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/network/local/firebase_utils.dart';
import 'package:todo/provider/settings_provider.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 150.0),
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: settingsProvider.isDarkMood()
                      ? MyTheme.lightPrimary
                      : Colors.grey[400],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Add New Task',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(
                    color: settingsProvider.isDarkMood()
                        ? Colors.white
                        : Colors.black),
                controller: titleController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Title must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      color: settingsProvider.isDarkMood()
                          ? Colors.white
                          : Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: settingsProvider.isDarkMood()
                        ? MyTheme.lightPrimary
                        : MyTheme.colorGrey,
                  )),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(
                    color: settingsProvider.isDarkMood()
                        ? Colors.white
                        : Colors.black),
                controller: descriptionController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Description must not be empty';
                  }
                  return null;
                },
                maxLines: 4,
                minLines: 2,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Description',
                  labelStyle: TextStyle(
                      color: settingsProvider.isDarkMood()
                          ? Colors.white
                          : Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: settingsProvider.isDarkMood()
                        ? MyTheme.lightPrimary
                        : MyTheme.colorGrey,
                  )),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showTaskDatePicker();
                  },
                  child: Text(
                    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskData task = TaskData(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate);
                    ShowLoading(context, 'Loading...');
                    addTaskToFirebaseFirestore(task).then((value) {
                      hideLaoding(context);
                      showMessage(
                          context,
                          'Task Added',
                          'Ok',
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          negBtn: 'cancel',
                          negAction: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                    }).onError((error, stackTrace) {
                      hideLaoding(context);
                      showMessage(context,
                          'Something went Wrong, try again later', 'Ok', () {
                        Navigator.pop(context);
                      });
                    }).timeout(const Duration(seconds: 5), onTimeout: () {
                      hideLaoding(context);
                      showMessage(context, 'Task Saved Locally', 'Ok', () {
                        Navigator.pop(context);
                      });
                    });
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    setState(() {
      if (chosenDate == null) return;
      selectedDate = chosenDate;
    });
  }
}
