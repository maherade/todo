import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/tasks_list/task_item.dart';

import '../network/local/firebase_utils.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: currentDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                currentDate = date;
              });
            },
            leftMargin: 20,
            monthColor:
                settingsProvider.isDarkMood() ? Colors.white : Colors.black,
            dayColor:
                settingsProvider.isDarkMood() ? Colors.white : Colors.black,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: MyTheme.lightPrimary,
            selectableDayPredicate: (day) => true,
            dotsColor: Colors.white,
          ),
          StreamBuilder<QuerySnapshot<TaskData>>(
              stream: getTasksFromFirestore(currentDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went Wrong'));
                }

                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

                if (tasks.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/data.png',
                      ),
                    ],
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItem(tasks[index]);
                      }),
                );
              })
        ],
      ),
    );
  }
}
