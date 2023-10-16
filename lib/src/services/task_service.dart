import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/model/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection(KString.taskCollection);

  Future<void> createTask(String description) async {
    try {
      var id = const Uuid().v4();
      User? user = getCurrentUser();
      var taskModel =
          TaskModel(taskId: id, description: description, isComplete: false);
      await taskCollection
          .doc(user!.uid)
          .collection(KString.taskListCollection)
          .doc(id)
          .set(taskModel.toMap());
    } catch (e) {
      // Handle error
      debugPrint('Error creating task: $e');
    }
  }

  Future<TaskModel?> findTaskById(String taskId) async {
    try {
      User? user = getCurrentUser();
      DocumentSnapshot<Map<String, dynamic>> taskSnapshot = await taskCollection
          .doc(user!.uid)
          .collection(KString.taskListCollection)
          .doc(taskId)
          .get();

      if (taskSnapshot.exists) {
        // Task with the provided ID found in the Firestore collection
        Map<String, dynamic> taskData = taskSnapshot.data()!;
        TaskModel task = TaskModel.fromJson(taskData);
        return task;
      } else {
        // Task with the provided ID not found
        return null;
      }
    } catch (e) {
      // Handle errors, such as Firestore exceptions or null user
      debugPrint('Error fetching task by ID: $e');
      return null;
    }
  }

  Future<void> updateTask(String taskId, String description,{bool? isTaskStatus}) async {
    try {
      User? user = getCurrentUser();
      TaskModel? model = await findTaskById(taskId);
      if (model != null) {
        model.description = description;
        model.isComplete = isTaskStatus??model.isComplete;
        await taskCollection
            .doc(user!.uid)
            .collection(KString.taskListCollection)
            .doc(taskId)
            .update(model.toMap());
      }
    } catch (e) {
      debugPrint('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      User? user = getCurrentUser();
      await taskCollection
          .doc(user!.uid)
          .collection(KString.taskListCollection)
          .doc(taskId)
          .delete();
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }

  User? getCurrentUser() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user;
      } else {
        // User is not logged in, handle accordingly
        debugPrint('User not logged in.');
        return null;
      }
    } catch (e) {
      debugPrint('Error updating task: $e');
      return null;
    }
  }

  Future<List<TaskModel>> getAllTaskList() async {
    List<TaskModel> tasks = [];

    try {
      User? user = getCurrentUser();
      QuerySnapshot<Map<String, dynamic>> taskSnapshot = await taskCollection
          .doc(user!.uid)
          .collection(KString.taskListCollection)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in taskSnapshot.docs) {
        TaskModel task = TaskModel.fromJson(doc.data());
        tasks.add(task);
      }
    } catch (e) {
      debugPrint('Error fetching task list: $e');
    }

    return tasks;
  }
}
