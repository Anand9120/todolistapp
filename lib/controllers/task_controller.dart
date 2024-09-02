// lib/controllers/task_controller.dart
import 'package:get/get.dart';
import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/view_models/task_view_model.dart';


class TaskController extends GetxController {
  final TaskViewModel taskViewModel = Get.put(TaskViewModel());

  var tasks = <TaskModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    tasks = taskViewModel.tasks;
    isLoading = taskViewModel.isLoading;
  }

  void addTask(TaskModel task) {
    taskViewModel.addTask(task);
  }

  void updateTask(TaskModel task) {
    taskViewModel.updateTask(task);
  }

  void deleteTask(String taskId) {
    taskViewModel.deleteTask(taskId);
  }
}
