import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_data.dart';

CollectionReference<TaskData> getTasksCollection() {
  return FirebaseFirestore.instance.collection('tasks').withConverter<TaskData>(
      fromFirestore: (snapshot, options) =>
          TaskData.fromJason(snapshot.data()!),
      toFirestore: (task, options) => task.toJason());
}

Future<void> addTaskToFirebaseFirestore(TaskData taskData) {
  var collection = getTasksCollection();
  var docRef = collection.doc();
  taskData.id = docRef.id;
  return docRef.set(taskData);
}

Stream<QuerySnapshot<TaskData>> getTasksFromFirestore(DateTime dateTime) {
  return getTasksCollection()
      .where('date',
          isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
      .snapshots();
}

Future<void> deleteTaskFromFireStore(String id) {
  return getTasksCollection().doc(id).delete();
}

Future<void> editTaskDetails(TaskData taskData) {
  CollectionReference editRef = getTasksCollection();

  return editRef.doc(taskData.id).update({
    "title": taskData.title,
    "description": taskData.description,
    "date": taskData.date.millisecondsSinceEpoch,
  });
}
