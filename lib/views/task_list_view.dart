
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/views/task_form_view.dart';


import '../controllers/task_controller.dart';

class TaskListView extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => TaskFormView());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text('${task.dueDate.toLocal()} - Priority: ${task.priority}'),
              onTap: () => Get.to(() => TaskFormView(task: task)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  taskController.deleteTask(task.id!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
