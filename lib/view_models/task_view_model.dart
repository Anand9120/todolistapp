import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/utils/notifications.dart';

class TaskViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var tasks = <TaskModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      isLoading(true);
      final snapshot = await _firestore.collection('tasks').get();
      tasks.value = snapshot.docs.map((doc) => TaskModel.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks');
    } finally {
      isLoading(false);
    }
  }

  void addTask(TaskModel task) async {
    try {
      final docRef = await _firestore.collection('tasks').add(task.toMap());
      tasks.add(task.copyWith(id: docRef.id));
      Notifications.scheduleNotification(task);
      Get.snackbar('Success', 'Task added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task');
    }
  }

  void updateTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update(task.toMap());
      final index = tasks.indexWhere((t) => t.id == task.id);
      tasks[index] = task;
      Notifications.scheduleNotification(task);
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    }
  }

  void deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      tasks.removeWhere((task) => task.id == taskId);
      Notifications.cancelNotification(taskId);
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }
}
