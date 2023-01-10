import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme/my_theme.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/tasks_list/edit_task_screen.dart';

import '../models/task_data.dart';
import '../network/local/firebase_utils.dart';

class TaskItem extends StatefulWidget {
  TaskData task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EditTaskScreen.routeName, arguments: widget.task);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(
            color: clicked == false
                ? Theme.of(context).primaryColor
                : MyTheme.colorGreen,
          ),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: .21,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (buildContext) {
                  deleteTaskFromFireStore(widget.task.id);
                },
                backgroundColor: Colors.red,
                label: 'Delete',
                icon: Icons.delete,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: settingsProvider.isDarkMood()
                  ? MyTheme.itemDarkColor
                  : Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: clicked == false
                        ? Theme.of(context).primaryColor
                        : MyTheme.colorGreen,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: clicked == false
                                ? Theme.of(context).primaryColor
                                : MyTheme.colorGreen),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.task.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: settingsProvider.isDarkMood()
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (clicked == false) {
                        clicked = true;
                      } else {
                        clicked = false;
                      }
                    });
                  },
                  child: clicked == false
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 32,
                          ))
                      : Text(
                          'Done!',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: MyTheme.colorGreen),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
